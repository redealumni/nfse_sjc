module NFSe
  module Documents
    class EnviarLoteRpsResposta < Base
      def process
        xml.EnviarLoteRpsResposta do
          build_field 'NumeroLote'
          build_field 'DataRecebimento'
          build_field 'Protocolo'
          build_into_self 'ListaMensagemRetorno', of: Types::ListaMensagemRetorno
        end
      end
    end
  end
end
