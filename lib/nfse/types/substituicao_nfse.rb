module NFSe
  module Types
    class SubstituicaoNFSe < Base
      def process
        build_into_self 'SubstituicaoNfse', of: Types::InfSubstituicaoNFSe
        build_into_self 'Signature', of: Types::Signature
      end
    end
  end
end
