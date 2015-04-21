# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'botrus/version'

Gem::Specification.new do |spec|
  spec.name          = "botrus"
  spec.version       = Botrus::VERSION
  spec.authors       = ["Peter Esselius"]
  spec.email         = ["pepp@me.com"]
  spec.summary       = %q{Cluster testing framework}
  spec.description   = %q{Framework for automating cluster testing}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "> 5.5"
  spec.add_development_dependency "minitest-rg"
end
