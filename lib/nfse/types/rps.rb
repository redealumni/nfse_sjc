module NFSe
  module Types
    class Rps < Base
      def process
        build_into_self 'InfRps', of: InfRps
        # build_into_self 'Signature', of: Signature
      end
    end
  end
end
