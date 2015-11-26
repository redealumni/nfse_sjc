module NFSe
  module Documents
    class ConsultarSituacaoLoteRpsResposta < Base
      def process
        xml.ConsultarSituacaoLoteRpsResposta do
          build_field 'NumeroLote'
          build_field 'Situacao'
          build_into_self 'ListaMensagemRetorno', of: Types::ListaMensagemRetorno
        end
      end
    end
  end
end
