module NFSe
  module Dirs
    def self.root
      File.dirname __dir__
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
  end
end

require_relative 'nfse/schemas'
require_relative 'nfse/params'
require_relative 'nfse/element'
require_relative 'nfse/version'
