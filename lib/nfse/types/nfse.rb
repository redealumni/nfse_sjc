module NFSe
  module Types
    class NFSe < Base
      def process
        build_into_self 'InfNfse', of: Types::InfNFSe
        build_into_self 'Signature', of: Types::Signature
      end
    end
  end
end
