module NFSe
  module Types
    class DadosServico < Base
      def process
        build_into_self 'Valores', of: Valores
        build_field 'ItemListaServico'
        build_field 'CodigoCnae', :optional
        build_field 'CodigoTributacaoMunicipio', :optional
        build_field 'Discriminacao'
        build_field 'CodigoMunicipio'
      end
    end
  end
end
