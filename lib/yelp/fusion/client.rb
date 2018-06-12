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
      attr_accessor :configuration

      # Creates an instance of the fusion client
      # @param options [String, nil] a consumer key
      # @return [Client] a new client initialized with the keys
      def initialize(option = nil)
        @configuration = nil
        unless option.nil?
          @configuration = Configuration.new(option)
        end
      end

        end
      end
    end
  end
end
