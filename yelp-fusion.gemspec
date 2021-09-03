lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yelp/fusion/version'

Gem::Specification.new do |spec|
  spec.name          = 'yelp-fusion'
  spec.version       = Yelp::Fusion::VERSION
  spec.authors       = ['Erik Grueter', 'Lyra Katzman']
  spec.email         = ['egrueter@jobcase.com', 'lkatzman@jobcase.com']

  spec.summary       = '{A Ruby gem for the Yelp Fusion (V3) API}'
  spec.description   = '{A Ruby gem for the Yelp Fusion (v3) API.}'
  spec.homepage      = 'https://github.com/erikgrueter1/yelp-fusion'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or
  # delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] =
  #   "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against ' \
  #     'public gem pushes.'
  # end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.2.2'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'faraday_middleware', '~> 0.12.2'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'pry-coolline', '~> 0.2.5'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.58'
  spec.add_development_dependency 'simplecov', '~> 0.16.0'
  spec.add_development_dependency 'vcr', '~> 4.0'
  spec.add_development_dependency 'webmock', '~> 3.4.2'

  spec.add_dependency 'faraday'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'minitest', '>= 4.2.0'
end
