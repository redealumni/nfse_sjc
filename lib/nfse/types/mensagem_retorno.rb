module NFSe
  module Types
    class MensagemRetorno < Base
      def process
        build_field 'Codigo'
        build_field 'Mensagem'
        build_field 'Correcao', :opcional
      end
    end
  end
end
