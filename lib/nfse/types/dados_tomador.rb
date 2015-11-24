module NFSe
  module Types
    class DadosTomador < Base
      def process
        build_into_self 'IdentificacaoTomador', :optional, of: IdentificacaoTomador
        build_field 'RazaoSocial', :optional
        build_into_self 'Endereco', :optional, of: Endereco
        build_into_self 'Contato', :optional, of: Contato
      end
    end
  end
end
