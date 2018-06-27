require 'erb'
require 'json'

require 'yelp/fusion/responses/phone'

module Yelp
  module Fusion
    module Endpoint
      class Phone
        PATH = '/v3/businesses/search/phone'.freeze

        def initialize(client)
          @client = client
        end

        # Make a request to the business endpoint on the API
        #
        # @param phone [String] the phone number
        # @return [Response::Phone] a parsed object of the response.
        #   For a complete sample response visit:
        #   https://www.yelp.com/developers/documentation/v3/business_search_phone
        #
        # @example Search for business with params and locale
        #
        #   response = client.phone_search('+14159083801')
        #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
        #   response.businesses[0].name # 'Yelp'
        def phone_search(phone)
          phone_hash = { phone: phone }
          Responses::Phone.new(JSON.parse(phone_request(phone_hash).body))
        end

        private

        # Make a request to the business endpoint of the API
        # The endpoint requires a format of /v3/business_search_phone
        # so the primary request parameter is concatenated. After getting
        # the response back it's checked to see if there are any API errors
        # and raises the relevant one if there is.
        #
        # @param phone [String] the phone number
        # @return [Faraday::Response] the raw response back from the connection
        def phone_request(phone)
          result = @client.connection.get PATH, phone
          Error.check_for_error(result)
          result
        end
      end
    end
  end
end