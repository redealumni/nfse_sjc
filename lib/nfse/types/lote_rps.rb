module NFSe
  module Types
    class LoteRps < Base
      def process
        build_attribute 'Id'
        build_field 'NumeroLote'
        build_field 'Cnpj'
        build_field 'InscricaoMunicipal'
        build_field 'QuantidadeRps'

        xml.listaRps do
          build_into_self 'Rps', of: Rps
        end
      end
    end
  end
end
