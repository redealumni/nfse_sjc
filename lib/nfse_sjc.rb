require 'nokogiri'
require 'savon'

require_relative 'nfse_sjc/dirs'
require_relative 'nfse_sjc/config'
require_relative 'nfse_sjc/schemas'
require_relative 'nfse_sjc/errors/validation_error'
require_relative 'nfse_sjc/response_hash'
require_relative 'nfse_sjc/parser'
require_relative 'nfse_sjc/document'
require_relative 'nfse_sjc/version'
require_relative 'nfse_sjc/client'

module NfseSjc
  def self.config(at: nil)
    if block_given?
      yield Config
    else
      Config.to_h(at: at)
    end
  end
end
