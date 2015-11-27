module NFSe
  module Types
    class DadosTomador < Base
      def process
        build_into_self 'IdentificacaoTomador', :optional, of: Types::IdentificacaoTomador
        build_field 'RazaoSocial', :optional
        build_into_self 'Endereco', :optional, of: Types::Endereco
        build_into_self 'Contato', :optional, of: Types::Contato
      end
    end
  end
end
