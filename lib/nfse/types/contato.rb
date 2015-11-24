module NFSe
  module Types
    class Contato < Base
      def process
        build_field 'Telefone', :optional
        build_field 'Email', :optional
      end
    end
  end
end
