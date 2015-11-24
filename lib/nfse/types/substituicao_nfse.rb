module NFSe
  module Types
    class SubstituicaoNFSe < Base
      def process
        build_into_self 'SubstituicaoNfse', of: InfSubstituicaoNFSe
        # build_into_self 'Signature', of: Signature
      end
    end
  end
end
