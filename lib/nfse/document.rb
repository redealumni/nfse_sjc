require 'erubis'
require 'xmldsig'
require 'openssl'

module NFSe
  class Document
    def initialize(filepath, params = {})
      @params = params
      @template = load_template(filepath)
    end

    def to_xml
      @template.result(binding)
    end

    def to_signed_xml(signing_params = {})
      signing_params = signing_params.merge(Config.default_config)
      unsigned_xml = to_xml

      private_key = OpenSSL::PKey::RSA.new(File.read(signing_params[:ssl_cert_key_file]),
        signing_params[:ssl_cert_key_password])
      certificate = OpenSSL::X509::Certificate.new(File.read signing_params[:ssl_cert_file])

      Xmldsig::SignedDocument.new(unsigned_xml).sign(private_key).tap do |signed_xml|
        raise "Invalid signature in XML" unless Xmldsig::SignedDocument.new(signed_xml).validate(certificate)
      end
    end

    protected
    def schema_path(schema)
      File.join NFSe::Dirs.etc, "schemas", schema
    end

    def render(filepath, params = {}, of: ::NFSe::Document)
      of.new(NFSe::Dirs.template(filepath), params).to_xml
    end

    def param(*path, with: @params)
      value = with
      path.each do |segment|
        value = value[segment]
        break if value.nil?
      end
      return value
    end

    def if_param(*path, with: @params)
      value = param(*path, with: with)
      yield value unless value.nil?
    end

    private
    def load_template(filepath)
      filename = File.basename filepath
      cachepath = File.join(Dir.tmpdir, "#{filename}.cache")
      Erubis::FastEruby.load_file(filepath, cachename: cachepath)
    end
  end
end