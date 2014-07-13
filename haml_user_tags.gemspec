# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'haml_user_tags/version'

Gem::Specification.new do |spec|
  spec.name          = "haml_user_tags"
  spec.version       = HamlUserTags::VERSION
  spec.authors       = ["Ryan Patterson"]
  spec.email         = ["cgamesplay@cgamesplay.com"]
  spec.summary       = "Helpers for Haml, in Haml."
  spec.description   = "Define reusable functions in Haml that can be called with native Haml syntax."
  spec.homepage      = "http://cgamesplay.github.io/haml_user_tags/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "haml", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"

  # Site dependencies
  spec.add_development_dependency "stasis", "~> 0.2"
  spec.add_development_dependency "therubyracer", "~> 0.12"
  spec.add_development_dependency "less", "~> 2.2"
  spec.add_development_dependency "pygments.rb", "~> 0.5"

  # Test dependencies
  spec.add_development_dependency "cucumber", "~> 1.3"
  spec.add_development_dependency "rspec-expectations", "~> 3.0"
  spec.add_development_dependency "fakefs", "~> 0.5"
end
