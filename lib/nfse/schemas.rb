require 'nokogiri'

module NFSe
  class Schemas
    def self.default_dir
      File.join NFSe::Dirs.etc, 'schemas'
    end

    def initialize(dir = Schemas.default_dir)
      @schemas = {}
      Dir.glob(File.join(dir, "servico_*.xsd")).each do |f|
        File.open(f) do |file_handle|
          @schemas[File.basename(f, ".xsd")] = Nokogiri::XML::Schema(file_handle)
        end
      end
    end

    def validate(operation, xml)
      @schemas[operation].validate(xml)
    end
  end
end
