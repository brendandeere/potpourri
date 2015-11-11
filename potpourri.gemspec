# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'potpourri/version'

Gem::Specification.new do |spec|
  spec.name          = "potpourri"
  spec.version       = Potpourri::VERSION
  spec.authors       = ["deereb"]
  spec.email         = ["brendan.g.deere@gmail.com"]

  spec.summary       = %q{Because you're tired of writting csv importer and exporters.}
  spec.description   = %q{A simple DSL to structure CSV importer and exporters for all of your models.}
  spec.homepage      = "https://github.com/brendandeere/potpourri"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com"
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
