require 'erubis'
require 'openssl'
require 'tempfile'

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
      # binding.pry

      signing_params = signing_params.merge(Config.default_config)
      unsigned_xml = Nokogiri::XML(to_xml)

      unsigned_temp_xml = Tempfile.new('unsigned-xml')
      signed_temp_xml   = Tempfile.new('signed-xml')
      result            = ''

      begin
        unsigned_temp_xml.write(unsigned_xml.to_xml)
        unsigned_temp_xml.rewind

        %x{xmlsec1 --sign --privkey-pem '#{signing_params[:ssl_cert_key_file]}','#{signing_params[:ssl_cert_file]}' --output '#{signed_temp_xml.path}' --pwd '#{signing_params[:ssl_cert_key_password]}' '#{unsigned_temp_xml.path}'}

        signed_temp_xml.rewind
        result = signed_temp_xml.read
      ensure
        signed_temp_xml.close
        unsigned_temp_xml.close

        signed_temp_xml.unlink
        unsigned_temp_xml.unlink
      end

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
