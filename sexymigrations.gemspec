# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sexymigrations/version'

Gem::Specification.new do |spec|
  spec.name          = "sexymigrations"
  spec.version       = Sexymigrations::VERSION
  spec.authors       = ["AlexShmatko"]
  spec.email         = ["alex.shmatko@active-bridge.com"]

  spec.summary       = %q{Allows you to make migrations look sexy.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/activebridge/sexy-migrations"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end