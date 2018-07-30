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

require 'json'
require 'yelp/fusion/responses/search'

module Yelp
  module Fusion
    module Endpoint
      class Search
        PATH = '/v3/businesses/search'.freeze
        def initialize(client)
          @client = client
        end

        # Take a search_request and return the formatted/structured
        # response from the API
        #
        # @param location [String] a string location of the neighborhood,
        #   address, or city
        # @param params [Hash] a hash that corresponds to params on the API:
        #   https://www.yelp.com/developers/documentation/v3/business_search
        # @return [Response::Search] a parsed object of the response.
        #   For a complete list of possible response values visit:
        #   https://www.yelp.com/developers/documentation/v3/business_search
        #
        # @example Search for business with params
        #   params = { term: 'food',
        #              limit: 3,
        #              category: 'discgolf' }
        #
        #   response = client.search('San Francisco', params)
        #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
        #   response.businesses[0].name # 'Yelp'
        def search(location, params = {})
          params[:location] = location

          Responses::Search.new(JSON.parse(search_request(params).body))
        end

        # Search by coordinates: give it a latitude and longitude along with
        # option accuracy, altitude, and altitude_accuracy to search an area.
        # More info at:
        # https://www.yelp.com/developers/documentation/v3/business_search
        #
        # @param coordinates [Hash] a hash of latitude and longitude.
        # @param params [Hash] a hash that corresponds to params on the API:
        #   https://www.yelp.com/developers/documentation/v3/business_search
        # @return [Response::Search] a parsed object of the response.
        #   For a complete list of possible response values visit:
        #   https://www.yelp.com/developers/documentation/v3/business_search
        #
        # @example Search for business with params
        #   coordinates = { latitude: 37.786732,
        #                   longitude: -122.399978 }
        #
        #   params = { term: 'food',
        #              limit: 3,
        #              category: 'discgolf' }
        #
        #   response = client.search(coordinates, params)
        #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
        #   response.businesses[0].name # 'Yelp'
        def search_by_coordinates(coordinates, params = {})
          raise Error::MissingLatLng if coordinates[:latitude].nil? ||
                                        coordinates[:longitude].nil?
          coordinates.merge!(params)
          Responses::Search.new(JSON.parse(search_request(coordinates).body))
        end

        private

        # Make a request against the search endpoint from the API and return the
        # raw response. After getting the response back it's checked to see if
        # there are any API errors and raises the relevant one if there is.
        #
        # @param params [Hash] a hash of parameters for the search request
        # @return [Faraday::Response] the raw response back from the connection
        def search_request(params)
          result = @client.connection.get PATH, params
          Yelp::Fusion::Error.check_for_error(result)
          result
        end
      end
    end
  end
end