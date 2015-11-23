module NFSe
  module Types
    class Contato < Base
      def process
        build_field 'Telefone'
        build_field 'Email'
      end
    end
  end
end
