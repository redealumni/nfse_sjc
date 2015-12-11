require 'nokogiri'

module NFSe
  module Dirs
    def self.root
      File.dirname __dir__
    end

    def self.bin
      File.join root, 'bin'
    end

    def self.lib
      File.join root, 'lib'
    end

    def self.etc
      File.join root, 'etc'
    end

    def self.template(filename)
      File.join etc, 'codegen', filename
    end
  end

  module Config
    class << self
      def self.default_attr(attr_name, env_path)
        attr_writer attr_name
        class_eval <<-RUBY
          def #{attr_name}
            @#{attr_name} ||= ENV['#{env_path}']
          end
        RUBY
      end

      default_attr :wsdl, 'NFSE_SJC_WSDL_URI'
      default_attr :ssl_cert_file, 'NFSE_SJC_SSL_CERT_FILE'
      default_attr :ssl_cert_key_file, 'NFSE_SJC_SSL_CERT_KEY_FILE'
      default_attr :ssl_cert_key_password, 'NFSE_SJC_SSL_CERT_KEY_PASSWORD'
      default_attr :log, 'NFSE_SJC_LOG'
      default_attr :pretty_print_xml, 'NFSE_SJC_PRETTY_XML_LOG'

      def default_config
        %i(wsdl ssl_cert_file ssl_cert_key_file ssl_cert_key_password log pretty_print_xml).map do |meth|
          val = send(meth)
          [meth, val] if val
        end.compact.to_h
      end
    end
  end

  def self.config
    yield Config
  end

  module Schemas
    MAPPING = {
      'cabecalho_v3.xml.erb' => 'cabecalho_v03.xsd',
      'cancelar_nfse_v3.xml.erb' => 'servico_cancelar_nfse_envio_v03.xsd',
      'consultar_lote_rps_v3.xml.erb' => 'servico_consultar_lote_rps_envio_v03.xsd',
      'consultar_nfse_rps_v3.xml.erb' => 'servico_consultar_nfse_rps_envio_v03.xsd',
      'consultar_nfse_v3.xml.erb' => 'servico_consultar_nfse_envio_v03.xsd',
      'consultar_situacao_lote_rps_v3.xml.erb' => 'servico_consultar_situacao_lote_rps_envio_v03.xsd',
      'recepcionar_lote_rps_v3.xml.erb' => 'servico_enviar_lote_rps_envio_v03.xsd'
    }

    def self.get_schema(template)
      MAPPING[template]
    end
  end

  class Client
    ValidationError = Class.new(RuntimeError)

    PARAM_KEYS = [:pretty_print_xml, :log, :wsdl, :ssl_cert_file,
      :ssl_cert_key_file, :ssl_cert_key_password].freeze

    def initialize(params = {})
      @savon = Savon.client slice(params, *PARAM_KEYS).merge(Config.default_config)
      @header = Document.new(Dirs.template('cabecalho_v3.xml.erb'), {}).to_xml.freeze
    end

    def call(method, params)
      schema = Schemas.get_schema("#{method}.xml.erb")
      schema_path = File.join Dirs.etc, 'schemas', schema
      xsd = Nokogiri::XML::Schema(File.open schema_path)
      document = Document.new(Dirs.template("#{method}.xml.erb"), params).to_signed_xml

      errors = xsd.validate(Nokogiri::XML(document))

      if errors.any?
        message = errors.map do |err|
          "* #{err}".gsub('{http://www.ginfes.com.br/tipos_v03.xsd}','').gsub('Element ', '')
        end.join("\n")

        raise ValidationError.new("XML with invalid or incorrect data according to schema #{schema}, found errors:\n #{message}")
      else
        @savon.call(method, message: {
          arg0: @header,
          arg1: document
        })
      end
    end

    private

    def slice(hash, *keys)
      keys.each_with_object({}) do |key, red|
        red[key] = hash[key] if hash.has_key?(key)
      end
    end
  end
end

require 'savon'
require_relative 'nfse/document'
require_relative 'nfse/version'

