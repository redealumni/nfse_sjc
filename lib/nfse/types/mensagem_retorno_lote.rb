module NFSe
  module Types
    class MensagemRetornoLote < Base
      def process
        build_into_self 'IdentificacaoRps', of: IdentificacaoRps
        build_field 'Codigo'
        build_field 'Mensagem'
      end
    end
  end
end
