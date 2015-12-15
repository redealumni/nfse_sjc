module NfseSjc
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

      default_attr :wsdl,                  'NFSE_SJC_WSDL_URI'
      default_attr :ssl_cert_file,         'NFSE_SJC_SSL_CERT_FILE'
      default_attr :ssl_cert_key_file,     'NFSE_SJC_SSL_CERT_KEY_FILE'
      default_attr :ssl_cert_key_password, 'NFSE_SJC_SSL_CERT_KEY_PASSWORD'
      default_attr :log,                   'NFSE_SJC_LOG'
      default_attr :pretty_print_xml,      'NFSE_SJC_PRETTY_XML_LOG'
      default_attr :xmlsec_binary_path,    'NFSE_SJC_XMLSEC_BINARY_PATH'

      def default_config
        %i(wsdl ssl_cert_file ssl_cert_key_file ssl_cert_key_password log pretty_print_xml).map do |meth|
          val = send(meth)
          [meth, val] if val
        end.compact.to_h
      end
    end
  end
end
