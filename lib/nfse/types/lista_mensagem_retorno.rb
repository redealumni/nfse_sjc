module NFSe
  module Types
    class ListaMensagemRetorno < Base
      def process
        params.MensagemRetorno.each do |msg|
          build_into_self 'MensagemRetorno', of: MensagemRetorno, with: msg
        end
      end
    end
  end
end
