# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nfse_sjc/version'

Gem::Specification.new do |spec|
  spec.name          = "nfse_sjc"
  spec.version       = NfseSjc::VERSION
  spec.authors       = ['Daniel Gracia', 'Thiago Brandão']
  spec.email         = ['daniel.santos@redealumni.com', 'thiago@redealumni.com']

  spec.summary       = %q{
    Gerador de NFS-e via API para a prefeitura de São José dos Campos
  }
  spec.description   = %q{
    Gem para comunicação via API com o sistema de NFS-e da prefeitura de São José dos Campos
  }
  spec.homepage      = "https://github.com/redealumni/nfse-sjc"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "erubis", "~> 2.7"
  spec.add_dependency "savon", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
