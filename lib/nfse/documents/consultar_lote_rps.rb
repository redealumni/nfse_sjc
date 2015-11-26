module NFSe
  module Documents
    class ConsultarLoteRps < Base
      def process
        xml.ConsultarLoteRpsEnvio do
          build_field 'Protocolo'
          build_into_self 'Prestador', of: Types::IdentificacaoPrestador
        end
      end
    end
  end
end
