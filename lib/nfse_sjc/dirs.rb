module NfseSjc
  module Dirs
    def self.root
      File.join(File.dirname(__dir__), '..')
    end

    def self.bin
      File.join root, 'bin'
    end

    def self.lib
      File.join root, 'lib'
    end

    def self.etc
      File.join root, 'etc'
    end

    def self.template(filename)
      File.join etc, 'codegen', filename
    end
  end
end
