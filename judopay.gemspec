# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'judopay/version'

Gem::Specification.new do |spec|
  spec.name          = "judopay"
  spec.version       = Judopay::VERSION
  spec.authors       = ["Chris Rosser"]
  spec.email         = ["chris@bluefuton.com"]
  spec.summary       = "Ruby SDK wrapper for the Judopay REST API"
  spec.description   = ""
  spec.homepage      = "http://www.judopay.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"  
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "yard-xml"
  spec.add_development_dependency "factory_girl"
  spec.add_dependency "faraday"
end
