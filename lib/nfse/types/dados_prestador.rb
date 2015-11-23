module NFSe
  module Types
    class DadosPrestador < Base
      def process
        build_into_self 'IdentificacaoPrestador', of: IdentificacaoPrestador
        build_field 'RazaoSocial'
        build_field 'NomeFantasia'
        build_into_self 'Endereco', of: Endereco
        build_into_self 'Contato', of: Contato
      end
    end
  end
end
