require 'faraday'
require 'faraday_middleware'
require 'yelp/fusion/configuration'
require 'yelp/fusion/error'

module Yelp
  module Fusion
    class Client
      API_HOST = 'https://api.yelp.com'.freeze
      API_VERSION_V3 = 'v3'.freeze

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

      # Creates a configuration with API keys
      # @return [@configuration] a frozen configuration
      def configure
        raise Error::AlreadyConfigured unless @configuration.nil?
        @configuration = Configuration.new
        yield(@configuration)
        check_api_keys
      end

      # Checks that all the keys needed were given
      # @return [@configuration] a frozen configuration
      def check_api_keys
        if @configuration.nil? || @configuration.api_key.nil? || defined?(@configuration.api_key).nil?
          @configuration = nil
          raise Error::MissingAPIKeys
        else
          # Freeze the configuration so it cannot be modified once the gem is
          # configured.  This prevents the configuration changing while the gem
          # is operating, which would necessitate invalidating various caches
          @configuration.freeze
        end
      end

      # API connection
      def connection
        return @connection if instance_variable_defined?(:@connection)

        check_api_keys
        @connection = Faraday.new(API_HOST) do |conn|
          # this guy uses oauth2 and bearer? maybe? to authorize the key
          conn.request :oauth2, @configuration.api_key, token_type: :bearer
          # Using default http library
          conn.adapter :net_http
        end
      end
    end
  end
end