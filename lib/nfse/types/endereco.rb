module NFSe
  module Types
    class Endereco < Base
      def process
        build_field 'Endereco', :optional
        build_field 'Numero', :optional
        build_field 'Complemento', :optional
        build_field 'Bairro', :optional
        build_field 'CodigoMunicipio', :optional
        build_field 'Uf', :optional
        build_field 'Cep', :optional
      end
    end
  end
end
