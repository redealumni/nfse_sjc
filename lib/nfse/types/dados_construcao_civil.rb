module NFSe
  module Types
    class DadosConstrucaoCivil < Base
      def process
        build_field 'CodigoObra'
        build_field 'Art'
      end
    end
  end
end
