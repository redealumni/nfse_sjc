module NFSe
  module Types
    class CancelamentoNFSe < Base
      def process
        build_into_self 'Confirmacao', of: Types::ConfirmacaoCancelamento
        build_into_self 'Signature', of: Types::Signature
      end
    end
  end
end
