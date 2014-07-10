# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'haml_user_tags/version'

Gem::Specification.new do |spec|
  spec.name          = "haml_user_tags"
  spec.version       = HamlUserTags::VERSION
  spec.authors       = ["Ryan Patterson"]
  spec.email         = ["cgamesplay@cgamesplay.com"]
  spec.summary       = %q{Define reusable functions in Haml that can be called with native Haml syntax.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "haml", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  # Site dependencies
  spec.add_development_dependency "stasis"
  spec.add_development_dependency "therubyracer"
  spec.add_development_dependency "less"
  spec.add_development_dependency "pygments.rb"

  # Test dependencies
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "fakefs"
end
