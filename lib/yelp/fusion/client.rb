# Copyright (c) Jobcase, Inc. All rights reserved. 

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
require 'faraday'
require 'faraday_middleware'
require 'yelp/fusion/configuration'
require 'yelp/fusion/error'
require 'yelp/fusion/endpoint/search'

module Yelp
  module Fusion
    class Client
      API_HOST = 'https://api.yelp.com'.freeze

      attr_accessor :configuration

      # Creates an instance of the fusion client
      # @param options [String, nil] a consumer key
      # @return [Client] a new client initialized with the keys
      def initialize(option = nil)
        @configuration = nil
        return if option.nil?
        @configuration = Configuration.new(option)
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
        if @configuration.nil? ||
           @configuration.api_key.nil? ||
           defined?(@configuration.api_key).nil?
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