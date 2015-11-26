module NFSe
  module Documents
    class ConsultarNfseResposta < Base
      def process
        xml.ConsultarNfseResposta do
          xml.ListaNfse do
            params.CompNfse.each do |cp|
              build_into_self 'CompNfse', of: Types::CompNfse, with: cp
            end
          end
          build_into_self 'ListaMensagemRetorno', of: Types::ListaMensagemRetorno
        end
      end
    end
  end
end
