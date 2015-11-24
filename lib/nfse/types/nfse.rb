module NFSe
  module Types
    class NFSe < Base
      def process
        build_into_self 'InfNfse', of: InfNFSe
        # build_into_self 'Signature', of: Signature
      end
    end
  end
end
