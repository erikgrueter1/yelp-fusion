require 'erb'
require 'json'

require 'yelp/fusion/responses/business'

module Yelp
  module Fusion
    module Endpoint
      class Transaction
        PATH = '/v3/transactions/'.freeze

        def initialize(client)
          @client = client
        end

        # Make a request to the business endpoint on the API
        #
        # @param id [String] the business id
        # @param locale [Hash] a hash of supported locale-related parameters
        # @return [Response::Review] the parsed response object from the API
        #
        # @example Get Transaction
        #   review = client.transaction('delivery', 'San Francisco')
        #   review.name # => 'Yelp'
        #   review.url  # => 'http://www.yelp.com/biz/yelp-san-francisco'
        def transaction_search(transaction_type, location)
          result = transaction_request(transaction_type, location)
          Responses::Transaction.new(JSON.parse(result.body))
        end

        # Search by coordinates: give it a latitude and longitude along with
        # option accuracy, altitude, and altitude_accuracy to search an area.
        # More info at
        # https://www.yelp.com/developers/documentation/v3/transaction_search
        #
        # @param coordinates [Hash] a hash of latitude and longitude.
        # @param params [Hash] a hash that corresponds to params on the API:
        #   https://www.yelp.com/developers/documentation/v3/transaction_search
        # @return [Response::Search] a parsed object of the response.
        #   For a complete list of possible response values visit:
        #   https://www.yelp.com/developers/documentation/v3/transaction_search
        #
        # @example Search for business with params
        #   coordinates = { latitude: 37.786732,
        #                   longitude: -122.399978 }
        #
        #   response = client.search('delivery', coordinates)
        #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
        #   response.businesses[0].name # 'Yelp'
        def transaction_by_coordinates(transaction_type, coordinates)
          raise Error::MissingLatLng if coordinates[:latitude].nil? ||
                                        coordinates[:longitude].nil?
          result = transaction_request(transaction_type, coordinates)
          Responses::Transaction.new(JSON.parse(result.body))
        end

        private

        # Make a request to the transaction endpoint of the API
        # The endpoint requires a format of /v3/transaction_search
        # so the primary request parameter is concatenated. After getting
        # the response back it's checked to see if there are any API errors
        # and raises the relevant one if there is.
        #
        # @param transaction_type [String] it has to be delivery
        # @param location [Hash] a hash of supported location
        # @return [Faraday::Response] the raw response back from the connection
        def transaction_request(transaction_type, location)
          result = @client.connection.get (PATH +
            ERB::Util.url_encode(transaction_type) + '/search'), location
          Error.check_for_error(result)
          result
        end
      end
    end
  end
end