require 'erb'
require 'json'

require 'yelp/fusion/responses/business'

module Yelp
  module Fusion
    module Endpoint
      class Match
        PATH = '/v3/businesses/matches'.freeze

        def initialize(client)
          @client = client
        end

        def match(params = {})
          Responses::Match.new(JSON.parse(match_request(params).body))
        end

        private

        def match_request(params = {})
          result = @client.connection.get PATH, params
          Error.check_for_error(result)
          result
        end
      end
    end
  end
end