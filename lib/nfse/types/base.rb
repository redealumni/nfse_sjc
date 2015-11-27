module NFSe
  module Types
    class Base < Element
      def choice(*keys)
        only_one = keys.one? { |k| params.has_key?(k) }
        unless only_one
          raise ArgumentError, "ambiguous parameters for choice field"
        end

        yield self
      end
    end
  end
end
