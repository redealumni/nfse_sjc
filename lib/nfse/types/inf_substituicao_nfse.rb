module NFSe
  module Types
    class InfSubstituicaoNFSe < Base
      def process
        build_attribute 'Id'
        build_field 'NfseSubstituidora'
      end
    end
  end
end
