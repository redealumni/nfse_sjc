module NFSe
  module Types
    class InfRps < Base
      def process
        build_attribute 'Id'
        build_into_self 'IdentificacaoRps', of: IdentificacaoRps
        build_field 'DataEmissao'
        build_field 'NaturezaOperacao'
        build_field 'RegimeEspecialTributacao', :optional
        build_field 'OptanteSimplesNacional'
        build_field 'IncentivadorCultural'
        build_field 'Status'
        build_into_self 'RpsSubstituido', :optional, of: IdentificacaoRps
        build_into_self 'Servico', of: DadosServico
        build_into_self 'Prestador', of: IdentificacaoPrestador
        build_into_self 'Tomador', of: DadosTomador
        build_into_self 'IntermediarioServico', :optional, of: IdentificacaoIntermediarioServico
        build_into_self 'ConstrucaoCivil', :optional, of: DadosConstrucaoCivil
      end
    end
  end
end
