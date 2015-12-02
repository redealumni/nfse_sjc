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

      def wsdl
        @wsdl ||= ENV['NFSE_SJC_WSDL_URI']
      end

      def ssl_cert_file
        @ssl_cert_file ||= ENV['NFSE_SJC_SSL_CERT_FILE']
      end

      def ssl_cert_key_file
        @ssl_cert_key_file ||= ENV['NFSE_SJC_SSL_CERT_KEY_FILE']
      end

      def ssl_cert_key_password
        @ssl_cert_key_password ||= ENV['NFSE_SJC_SSL_CERT_KEY_PASSWORD']
      end
    end
  end

  def self.config
    yield Config
  end

  class Client
    def initialize(params = {})
      @savon = Savon.client slice(params, :wsdl, :ssl_cert_file, :ssl_cert_key_file, :ssl_cert_key_password).merge({
        wsdl: Config.wsdl, ssl_cert_file: Config.ssl_cert_file,
        ssl_cert_key_file: Config.ssl_cert_key_file, ssl_cert_key_password: Config.ssl_cert_key_password
      })

      @header = Document.new(Dirs.template('cabecalho_v3.xml.erb'), {
        'Cabecalho' => {
          'Versao' => '03', 'VersaoDados' => '03'
        }
      }).to_xml.freeze
    end

    def call(method, params)
      @savon.call(method, message: {
        arg0: @header,
        arg1: Document.new(Dirs.template("#{method}.xml.erb"), params)
      })
    end

    private
    def slice(hash, *keys)
      keys.each_with_object({}) do |key, red|
        red[key] = hash[key]
      end
    end
  end
end

require 'savon'
require_relative 'nfse/document'
require_relative 'nfse/version'

