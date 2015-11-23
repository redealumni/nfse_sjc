module NFSe
  module Types
    class IdentificacaoRPS < Base
      def process
        build_field 'Numero'
        build_field 'Serie'
        build_field 'Tipo'
      end
    end
  end
end
