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
      attr_writer :wsdl, :ssl_cert_file, :ssl_cert_key_file, :ssl_cert_key_password
      def self.default_attr(attr_name, env_path)
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

  class Client
    PARAM_KEYS = [:pretty_print_xml, :log, :wsdl, :ssl_cert_file,
      :ssl_cert_key_file, :ssl_cert_key_password].freeze

    def initialize(params = {})
      @savon = Savon.client slice(params, *PARAM_KEYS).merge(Config.default_config)
      @header = Document.new(Dirs.template('cabecalho_v3.xml.erb'), {}).to_xml.freeze
    end

    def call(method, params)
      @savon.call(method, message: {
        arg0: @header,
        arg1: Document.new(Dirs.template("#{method}.xml.erb"), params).to_xml
      })
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

