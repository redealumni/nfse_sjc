require 'hashie'

module NFSe
  class Params < Hash
    # Add Hashie extensions for "smartest hash ever"
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MethodAccess

    def self.wrap(hash)
      hash.is_a?(self) ? hash : self.new(hash)
    end

    def slice(*keys)
      keys.each_with_object(self.class.new) do |key, hash|
        hash[key] = self[key]
      end
    end
  end
end
