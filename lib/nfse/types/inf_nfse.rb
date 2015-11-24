module NFSe
  module Types
    class InfNFSe < Base
      def process
        build_attribute 'Id'
        build_field 'Numero'
        build_field 'CodigoVerificacao'
        build_field 'DataEmissao'
        build_into_self 'IdentificacaoRps', :optional, of: IdentificacaoRps
        build_field 'DataEmissaoRps', :optional
        build_field 'NaturezaOperacao'
        build_field 'RegimeEspecialTributacao', :optional
        build_field 'OptanteSimplesNacional'
        build_field 'IncentivadorCultural'
        build_field 'Competencia'
        build_field 'NfseSubstituida', :optional
        build_field 'OutrasInformacoes', :optional
        build_into_self 'Servico', of: DadosServico
        build_field 'ValorCredito', :optional
        build_into_self 'PrestadorServico', of: IdentificacaoPrestador
        build_into_self 'TomadorServico', of: DadosTomador
        build_into_self 'IntermediarioServico', :optional, of: IdentificacaoIntermediarioServico
        build_into_self 'OrgaoGerador', of: IdentificacaoOrgaoGerador
        build_into_self 'ConstrucaoCivil', :optional, of: DadosConstrucaoCivil
      end
    end
  end
end
