module NFSe
  module Types
    class PedidoCancelamento < Base
      def process
        build_into_self 'InfPedidoCancelamento', of: Types::InfPedidoCancelamento
        build_into_self 'Signature', of: Types::Signature
      end
    end
  end
end
