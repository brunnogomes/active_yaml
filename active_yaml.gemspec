# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_yaml/version'

Gem::Specification.new do |spec|
  spec.name          = "active_yaml"
  spec.version       = ActiveYaml::VERSION
  spec.authors       = ["Brunno Gomes"]
  spec.email         = ["brunnolgp@gmail.com"]
  spec.description   = %q{A simple key/value storage built on top of YAML::Store with an ActiveRecord like interface}
  spec.summary       = %q{ActiveRecord like YAML key/value store}
  spec.homepage      = "https://github.com/brunnogomes/active_yaml"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
