require 'erubis'

module NFSe
  class Document
    def initialize(filepath, params = {})
      @params = params
      @template = load_template(filepath)
    end

    def to_xml
      @template.result(binding)
    end

    protected
    def schema_path(schema)
      File.join NFSe::Dirs.etc, "schemas", schema
    end

    def render(filepath, params = {}, of: ::NFSe::Document)
      of.new(NFSe::Dirs.template(filepath), params).to_xml
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

    private
    def load_template(filepath)
      filename = File.basename filepath
      cachepath = File.join(Dir.tmpdir, "#{filename}.cache")
      Erubis::FastEruby.load_file(filepath, cachename: cachepath)
    end
  end
end