module NfseSjc
  class ResponseHash
    def initialize(hash)
      @hash = hash
    end

    def to_deep_symbolized_h
      @hash.inject(Hash.new) do |h, (k, v)|
        h.merge!({
          k.snakecase.to_sym => (
            case v
            when Hash
              ResponseHash.new(v).to_deep_symbolized_h
            when Array
              v.map{|item| ResponseHash.new(item).to_deep_symbolized_h}
            else
              v
            end
          )
        })
      end
    end
  end
end
