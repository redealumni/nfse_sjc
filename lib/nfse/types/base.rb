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

      def build_attribute(name, with: params[name])
        xml.parent[name] = with
      end

      def params
        @params
      end

      def choice(*keys)
        only_one = keys.one? { |k| params.has_key?(k) }
        unless only_one
          raise InvalidArgumentError, "ambiguous parameters for choice field"
        end

        yield self
      end

      def build_field(name, optional = false)
        if optional
          return unless params.has_key?(name)
        end

        xml.send(name, params[name])
      end

      def build_into_self(element, optional = false, of:, with: params[element])
        if optional
          return unless (with.nil? || with.empty?)
        end

        xml.send(element) do
          of.build_into(self, with: with)
        end
      end
    end
  end
end