module NFSe
  module Types
    class DadosPrestador < Base
      def process
        build_into_self 'IdentificacaoPrestador', of: Types::IdentificacaoPrestador
        build_field 'RazaoSocial'
        build_field 'NomeFantasia', :optional
        build_into_self 'Endereco', of: Types::Endereco
        build_into_self 'Contato', :optional, of: Types::Contato
      end
    end
  end
end
