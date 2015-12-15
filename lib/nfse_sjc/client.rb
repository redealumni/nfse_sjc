module NfseSjc
  class Client
    PARAM_KEYS = [:pretty_print_xml, :log, :wsdl, :ssl_cert_file,
      :ssl_cert_key_file, :ssl_cert_key_password].freeze

    def initialize(params = {})
      @savon  = Savon.client slice(params, *PARAM_KEYS).merge(Config.default_config)
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

    def method_missing(name, *args, &block)
      call(name, *args, &block)
    end

    private

    def slice(hash, *keys)
      keys.each_with_object({}) do |key, red|
        red[key] = hash[key] if hash.has_key?(key)
      end
    end
  end
end
