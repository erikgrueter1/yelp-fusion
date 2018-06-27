require 'erb'
require 'json'

require 'yelp/fusion/responses/business'

module Yelp
  module Fusion
    module Endpoint
      class Business
        PATH = '/v3/businesses/'.freeze

        def initialize(client)
          @client = client
        end

        def business(id, locale = {})
          Responses::Business.new(JSON.parse(business_request(id, locale).body))
        end

        private

        def business_request(id, locale = {})
          result = @client.connection.get (PATH +
            ERB::Util.url_encode(id)), locale
          Error.check_for_error(result)
          result
        end
      end
    end
  end
end