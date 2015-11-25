module NFSe
  module Types
    class IdentificacaoPrestador < Base
      def process
        build_field 'Cnpj'
        build_field 'InscricaoMunicipal', :optional
      end
    end
  end
end