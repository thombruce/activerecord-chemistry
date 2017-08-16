# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord/chemistry/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-chemistry"
  spec.version       = ActiveRecord::Chemistry::VERSION
  spec.authors       = ["Thom Bruce"]
  spec.email         = ["thom@thombruce.com"]

  spec.summary       = %q{Adds inheritance logic for Rails ActiveRecord.}
  spec.description   = %q{Adds several different inheritance patterns for use with Rails models and ActiveRecord relations.}
  spec.homepage      = "http://github.com/thombruce/activerecord-chemistry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.required_ruby_version = ">= 2.4"
  
  spec.add_development_dependency "sqlite3", "~> 1.3"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_development_dependency "factory_girl", "~> 4.8.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3"
  spec.add_development_dependency "rubocop", "~> 0.49.1"
  
  spec.add_dependency "activesupport", ">= 5.1"
  spec.add_dependency "activerecord", ">= 5.1"
end
