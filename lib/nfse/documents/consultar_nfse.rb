module NFSe
  module Documents
    class ConsultarNfse < Base
      def process
        xml.ConsultarNfse do
          build_into_self 'Prestador', of: Types::IdentificacaoPrestador
          build_field 'NumeroNfse'
          xml.PeriodoEmissao do
            build_attribute 'DataInicial'
            build_attribute 'DataFinal'
          end
          build_into_self 'Tomador', of: Types::IdentificacaoTomador
          build_into_self 'IntermediarioServico', of: Types::IdentificacaoIntermediarioServico
        end
      end
    end
  end
end
