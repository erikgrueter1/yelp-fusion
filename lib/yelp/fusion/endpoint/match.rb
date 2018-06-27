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

        # Make a request to the business endpoint on the API
        #
        # @param params [Hash] a hash of the required location parameters
        # @return [Response::Match] a parsed object of the response. For a complete
        #   sample response visit:
        #   https://www.yelp.com/developers/documentation/v3/business_match
        #
        # @example Search for business with params
        #   params = { name: 'swissbakers', address1: '168 Western Ave', 
        #   city: 'allston', state: 'MA', country: 'US' }
        #   response = client.mathc(params)
        #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
        #   response.businesses[0].name # 'Yelp'
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