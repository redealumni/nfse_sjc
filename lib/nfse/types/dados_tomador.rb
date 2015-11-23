module NFSe
  module Types
    class DadosTomador < Base
      def process
        build_into_self 'IdentificacaoTomador', of: IdentificacaoTomador
        build_field 'RazaoSocial'
        build_into_self 'Endereco', of: Endereco
        build_into_self 'Contato', of: Contato
      end
    end
  end
end
