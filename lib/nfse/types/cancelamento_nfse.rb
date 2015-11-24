module NFSe
  module Types
    class CancelamentoNFSe < Base
      def process
        build_into_self 'Confirmacao', of: ConfirmacaoCancelamento
        # build_into_self 'Signature', of: Signature
      end
    end
  end
end
