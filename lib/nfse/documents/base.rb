module NFSe
  module Documents
    class Base < Element
      def initialize(*)
        super

        xml.cabecalho do
          build_attribute "Versao", params.Versao
          build_field "versaoDados"
        end
      end
    end
  end
end
