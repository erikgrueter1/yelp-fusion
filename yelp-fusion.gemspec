# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yelp/fusion/version"

Gem::Specification.new do |spec|
  spec.name          = "yelp-fusion"
  spec.version       = Yelp::Fusion::VERSION
  spec.authors       = ["Erik Grueter"]
  spec.email         = ["erikgrueter@gmail.com"]

  spec.summary       = %q{A Ruby gem for the Yelp Fusion (V3) API and beyond}
  spec.description   = %q{A Ruby gem for the Yelp Fucsion (v3) API. It is built to support future versions}
  spec.homepage      = "http://www.google.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry-coolline'
  spec.add_development_dependency 'pry'

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'minitest'
end
