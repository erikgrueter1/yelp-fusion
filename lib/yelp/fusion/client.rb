require 'faraday'
require 'faraday_middleware'

require 'yelp/fusion/configuration'

module Yelp
  module Fusion
    class Client
      API_HOST = 'https://api.yelp.com'.freeze
      API_VERSION_V3 = 'v3'.freeze

      # docuemnt
      def initialize(options = nil)
        unless options.nil?
          @configuration = Configuration.new(options)
        end
      end
    end
  end
end
