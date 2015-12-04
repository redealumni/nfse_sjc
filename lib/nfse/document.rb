require 'erubis'
require 'openssl'
require 'nokogiri-xmlsec'

module NFSe
  class Document
    def initialize(filepath, params = {})
      @params = params
      @basename = File.basename filepath
      @schema = Schemas.get_schema @basename
      @template = load_template(filepath)
    end

    def to_xml
      @template.result(binding)
    end

    def to_signed_xml(signing_params = {})
      signing_params = signing_params.merge(Config.default_config)
      signed_xml = Nokogiri::XML(to_xml)

      signed_xml.root.sign!({
        cert: signing_data(signing_params[:ssl_cert_file]),
        key: signing_data(signing_params[:ssl_cert_key_file]),
        digest_alg: 'sha1',
        signature_alg: 'rsa-sha1'
      })

      signature_ns = signed_xml.root.namespace_definitions.find{|ns| ns.prefix == "ds"}
      signed_xml.at_xpath('//ds:Signature').tap do |signature|
        signature.traverse do |node|
          node.namespace = signature_ns
        end
      end

      result = signed_xml.to_xml(indent: 2)
      binding.pry
      result
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
      cachepath = File.join(Dir.tmpdir, "#{@basename}.cache")
      Erubis::FastEruby.load_file(filepath, cachename: cachepath)
    end

    def signing_data(filename)
      @@signing_data ||= {}
      @@signing_data[filename] = File.read(filename) unless @@signing_data[filename]
      @@signing_data[filename]
    end
  end
end
