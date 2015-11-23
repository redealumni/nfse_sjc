module NFSe
  module Types
    class Endereco < Base
      def process
        build_field 'Endereco'
        build_field 'Numero'
        build_field 'Complemento'
        build_field 'Bairro'
        build_field 'CodigoMunicipio'
        build_field 'Uf'
        build_field 'Cep'
      end
    end
  end
end
