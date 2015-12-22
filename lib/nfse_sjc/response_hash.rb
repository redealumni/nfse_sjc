module NfseSjc
  class ResponseHash
    def initialize(hash)
      @hash = hash
    end

    def to_deep_symbolized_h
      @hash.inject(Hash.new) do |h, (k, v)|
        h.merge!({k.snakecase.to_sym => (v.is_a?(Hash) ? ResponseHash.new(v).to_deep_symbolized_h : v)})
      end
    end
  end
end
