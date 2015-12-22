module NfseSjc
  class Parser
    def initialize
      @nori = Nori.new({
        delete_namespace_attributes: true,
        strip_namespaces: true,
        convert_dashes_to_underscores: true
      })
    end

    def parse(response)
      ResponseHash.new(@nori.parse(response)).to_deep_symbolized_h
    end
  end
end
