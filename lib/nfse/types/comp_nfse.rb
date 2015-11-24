module NFSe
  module Types
    class CompNFSe < Base
      def process
        build_into_self 'Nfse', of: NFSe
        build_into_self 'NfseCancelamento', :opcional, of: CancelamentoNFSe
        build_into_self 'NfseSubstituicao', :opcional, of: SubstituicaoNFSe
      end
    end
  end
end
