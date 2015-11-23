require 'bigdecimal'
require 'bigdecimal/util'

module NFSe
  module Types
    class Valores < Base
      def process
        build_field 'ValorServicos'
        build_field 'ValorDeducoes'
        build_field 'ValorPis'
        build_field 'ValorCofins'
        build_field 'ValorInss'
        build_field 'ValorIr'
        build_field 'ValorCsll'
        build_field 'IssRetido'
        build_field 'ValorIss'
        build_field 'OutrasRetencoes'
        
        # Base de calculo, gerada automaticamente
        valorBase = params.values_at('ValorServicos', 'ValorDeducoes', 'DescontoIncondicionado')
          .map(&:to_s).map(&:to_d).reduce(:-)
        xml.BaseCalculo valorBase.truncate(2).to_s("F")

        build_field 'Aliquota'

        # Valor líquido da nota
        valorLiquido = params.values_at(*%W(
          ValorServicos ValorPis ValorCofins ValorInss ValorIr ValorCsll OutrasRetencoes
          ValorIssRetido DescontoIncondicionado DescontoCondicionado)).map(&:to_s).map(&:to_d).reduce(:-)
        xml.ValorLiquidoNfse valorLiquido.truncate(2).to_s("F")

        build_field 'ValorIssRetido'
        build_field 'DescontoCondicionado'
        build_field 'DescontoIncondicionado'
      end
    end
  end
end
