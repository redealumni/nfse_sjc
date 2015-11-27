module NFSe
  module Types
    class Rps < Base
      def process
        build_into_self 'InfRps', of: Types::InfRps
        build_into_self 'Signature', of: Types::Signature
      end
    end
  end
end
