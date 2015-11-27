module NFSe
  module Types
    class CompNFSe < Base
      def process
        build_into_self 'Nfse', of: Types::NFSe
        build_into_self 'NfseCancelamento', :opcional, of: Types::CancelamentoNFSe
        build_into_self 'NfseSubstituicao', :opcional, of: Types::SubstituicaoNFSe
      end
    end
  end
end
