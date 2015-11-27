module NFSe
  module Types
    class ConfirmacaoCancelamento < Base
      def process
        build_attribute 'Id'
        build_into_self 'Pedido', of: Types::PedidoCancelamento
        build_into_self 'InfConfirmacaoCancelamento', of: Types::InfConfirmacaoCancelamento
      end
    end
  end
end
