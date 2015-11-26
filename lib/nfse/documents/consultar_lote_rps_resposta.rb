module NFSe
  module Documents
    class ConsultarLoteRpsResposta < Base
      def process
        xml.ConsultarLoteRpsResposta do
          xml.ListaNfse do
            build_into_self 'CompNfse', of: Types::CompNFSe
          end
          build_into_self 'ListaMensagemRetorno', of: Types::ListaMensagemRetorno
        end
      end
    end
  end
end
