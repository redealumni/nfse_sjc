module NFSe
  module Types
    class InfNFSe < Base
      def process
        build_attribute 'Id'
        build_field 'Numero'
        build_field 'CodigoVerificacao'
        build_field 'DataEmissao'
        build_into_self 'IdentificacaoRps', :optional, of: Types::IdentificacaoRps
        build_field 'DataEmissaoRps', :optional
        build_field 'NaturezaOperacao'
        build_field 'RegimeEspecialTributacao', :optional
        build_field 'OptanteSimplesNacional'
        build_field 'IncentivadorCultural'
        build_field 'Competencia'
        build_field 'NfseSubstituida', :optional
        build_field 'OutrasInformacoes', :optional
        build_into_self 'Servico', of: Types::DadosServico
        build_field 'ValorCredito', :optional
        build_into_self 'PrestadorServico', of: Types::IdentificacaoPrestador
        build_into_self 'TomadorServico', of: Types::DadosTomador
        build_into_self 'IntermediarioServico', :optional, of: Types::IdentificacaoIntermediarioServico
        build_into_self 'OrgaoGerador', of: Types::IdentificacaoOrgaoGerador
        build_into_self 'ConstrucaoCivil', :optional, of: Types::DadosConstrucaoCivil
      end
    end
  end
end
