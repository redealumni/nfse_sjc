module NFSe
  module Types
    class IdentificacaoOrgaoGerador < Base
      def process
        build_field 'CodigoMunicipio'
        build_field 'Uf'
      end
    end
  end
end
