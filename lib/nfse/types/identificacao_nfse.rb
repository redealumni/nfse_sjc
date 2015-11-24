module NFSe
  module Types
    class IdentificacaoNFSe < Base
      def process
        build_field 'Numero'
        build_field 'Cnpj'
        build_field 'InscricaoMunicipal', :optional
        build_field 'CodigoMunicipio'
      end
    end
  end
end
