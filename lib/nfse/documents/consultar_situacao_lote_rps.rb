module NFSe
  module Documents
    class ConsultarSituacaoLoteRps < Base
      def process
        xml.ConsultarSituacaoLoteRpsEnvio do
          build_field 'Protocolo'
          build_into_self 'Prestador', of: Types::IdentificacaoPrestador
        end
      end
    end
  end
end
