require 'bigdecimal'
require 'bigdecimal/util'

module NFSe
  module Types
    class Valores < Base
      def process
        build_field 'ValorServicos'
        build_field 'ValorDeducoes', :optional
        build_field 'ValorPis', :optional
        build_field 'ValorCofins', :optional
        build_field 'ValorInss', :optional
        build_field 'ValorIr', :optional
        build_field 'ValorCsll', :optional
        build_field 'IssRetido'
        build_field 'ValorIss', :optional
        build_field 'OutrasRetencoes', :optional
        
        # Base de calculo, gerada automaticamente
        valorBase = params.values_at('ValorServicos', 'ValorDeducoes', 'DescontoIncondicionado')
          .map(&:to_s).map(&:to_d).reduce(:-)
        xml.BaseCalculo valorBase.truncate(2).to_s("F")

        build_field 'Aliquota', :optional

        # Valor líquido da nota
        valorLiquido = params.values_at(*%W(
          ValorServicos ValorPis ValorCofins ValorInss ValorIr ValorCsll OutrasRetencoes
          ValorIssRetido DescontoIncondicionado DescontoCondicionado)).map(&:to_s).map(&:to_d).reduce(:-)
        xml.ValorLiquidoNfse valorLiquido.truncate(2).to_s("F")

        build_field 'ValorIssRetido', :optional
        build_field 'DescontoCondicionado', :optional
        build_field 'DescontoIncondicionado', :optional
      end
    end
  end
end
