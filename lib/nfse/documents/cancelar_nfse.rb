module NFSe
  module Documents
    class CancelarNfse < Base
      def process
        xml.CancelarNfseEnvio do
          build_into_self 'Pedido', of: Types::PedidoCancelamento
        end
      end
    end
  end
end
