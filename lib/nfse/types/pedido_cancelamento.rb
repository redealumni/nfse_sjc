module NFSe
  module Types
    class PedidoCancelamento < Base
      def process
        build_into_self 'InfPedidoCancelamento', of: InfPedidoCancelamento
        # build_into_self 'Signature', of: Signature
      end
    end
  end
end
