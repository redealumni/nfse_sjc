module NFSe
  module Documents
    class CancelarNfseReposta < Base
      def process
        xml.CancelarNfseResposta do
          build_into_self 'Cancelamento', of: Types::CancelamentoNfse
          build_into_self 'ListaMensagemRetorno', of: Types::ListaMensagemRetorno
        end
      end
    end
  end
end
