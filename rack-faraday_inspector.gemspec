# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/faraday_inspector/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-faraday_inspector"
  spec.version       = Rack::FaradayInspector::VERSION
  spec.authors       = ["Chris Bielinski"]
  spec.email         = ["chris@shadow.io"]

    spec.summary       = %q{View Faraday requests made in your controllers on rendered pages}
  spec.description   = %q{View Faraday requests made in your controllers on rendered pages}
  spec.homepage      = "https://github.com/chrisb/rack-faraday_inspector"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday_middleware'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
