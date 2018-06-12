require 'yelp/fusion/client'

module Yelp
  module Fusion
    # Returns an initially-unconfigured instance of the client.
    # @return [Client] an instance of the client
    #
    # @example Configuring and using the client
    #   Yelp::Fusion.client.configure do |config|
    #     config.api_key = 'abc'
    #   end
    def self.client
      @client ||= Yelp::Fusion::Client.new
    end
  end
end