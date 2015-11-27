require 'hashie'

module NFSe
  class Params < Hash
    # Add Hashie extensions for "smartest hash ever"
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::MethodAccess
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::DeepMerge

    def self.wrap(hash)
      hash.is_a?(self) ? hash : self.new.deep_merge!(hash)
    end

    def slice(*keys)
      keys.each_with_object(self.class.new) do |key, hash|
        hash[key] = self[key]
      end
    end

    def indifferent_value(value)
      if hash_lacking_indifference?(value)
        self.class[value].convert!
      elsif value.is_a?(::Array)
        value.replace(value.map { |e| indifferent_value(e) })
      else
        value
      end
    end
  end
end
