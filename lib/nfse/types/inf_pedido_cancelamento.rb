module NFSe
  module Types
    class InfPedidoCancelamento < Base
      def process
        build_attribute 'Id'
        build_into_self 'IdentificacaoNfse', of: Types::IdentificacaoNFSe
        build_field 'CodigoCancelamento'
      end
    end
  end
end
