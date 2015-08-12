# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'friendly_responses/version'

Gem::Specification.new do |spec|
  spec.name          = "friendly_responses"
  spec.version       = FriendlyResponses::VERSION
  spec.authors       = ["Jordan Bach"]
  spec.email         = ["jbach@kalkomey.com"]

  spec.summary       = %q{Friendly error responses for RESTful Rails APIs.}
  spec.homepage      = "https://github.com/kalkomey/friendly_responses"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", "~> 4.0"
  spec.add_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
