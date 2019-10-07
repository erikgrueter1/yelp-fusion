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

require 'erb'
require 'json'

require 'yelp/fusion/responses/business'

# Yelp::Fusion::Endpoint::Transaction
#
module Yelp
  module Fusion
    module Endpoint
      # Endpoint to search for Yelp transactions
      class Transaction
        PATH = '/v3/transactions/'.freeze

        def initialize(client)
          @client = client
        end

        # Make a request to the transaction search endpoint of the API
        # @param transaction_type [String] it has to be delivery
        # @param location [Hash] a hash of supported locatio
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