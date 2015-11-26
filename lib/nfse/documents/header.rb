module NFSe
  module Documents
    class Header < Base
      def process
        xml.cabecalho do
          build_attribute "Versao", params.Versao
          build_field "versaoDados"
        end
      end
    end
  end
end
