require 'erubis'

module NFSe
  class Document
    def initialize(filepath, params = {})
      @params = params
      @file = File.read(filepath)
    end

    def to_xml
      Erubis::Eruby.new(@file).result(binding)
    end

    protected
    def schema_path(schema)
      File.join NFSe::Dirs.etc, "schemas", schema
    end

    def render(filepath, params = {}, of: ::NFSe::Document)
      of.new(filepath, params).to_xml
    end

    def param(*path, with: @params)
      value = with
      path.each do |segment|
        value = value[segment]
        break if value.nil?
      end
      return value
    end

    def if_param(*path, with: @params)
      value = param(*path, with: with)
      yield value unless value.nil?
    end
  end
end