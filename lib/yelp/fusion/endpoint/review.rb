require 'erb'
require 'json'

require 'yelp/fusion/responses/review'

module Yelp
  module Fusion
    module Endpoint
      class Review
        PATH = '/v3/businesses/'.freeze

        def initialize(client)
          @client = client
        end

        def review(id, locale = {})
          Responses::Review.new(JSON.parse(review_request(id, locale).body))
        end

        private

        def review_request(id, locale = {})
          result = @client.connection.get (PATH +
            ERB::Util.url_encode(id) + '/reviews'), locale
          Error.check_for_error(result)
          result
        end
      end
    end
  end
end