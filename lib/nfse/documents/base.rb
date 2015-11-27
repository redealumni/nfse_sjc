module NFSe
  module Documents
    class Base < Element
      def initialize(*)
        super

        xml.cabecalho do
          build_attribute "Versao", with: params.Versao
          build_field "versaoDados"
        end
      end

      def self.create(name, params)
        b = Nokogiri::XML::Builder.new do |xml|
          xml.send(name) do
            self.new(xml, params).process
          end
        end
        b.to_xml
      end
    end
  end
end
