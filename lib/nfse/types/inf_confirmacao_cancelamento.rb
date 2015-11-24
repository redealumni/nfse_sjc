module NFSe
  module Types
    class InfConfirmacaoCancelamento < Base
      def process
        build_field 'Sucesso'
        build_field 'DataHora'
      end
    end
  end
end
