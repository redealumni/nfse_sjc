module NFSe
  module Types
    class Base
      def self.build_into(current, with: {})
        self.new(current).with_fields(with).process
      end

      def initialize(builder = Nokogiri::XML::Builder.new)
        @builder = builder
      end

      def with_params
        @params = NFSe::Params.wrap(params)
        self
      end

      def process
        raise NotImplementedError
      end

      protected
      def xml
        @builder
      end

      def params
        @params
      end

      def build_field(name)
        xml.send(name, params[name])
      end

      def build_into_self(element, of:, with: params[element])
        xml.send(elemend) do
          of.build_into(self, with: with)
        end
      end
    end
  end
end