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

# Yelp::Fusion::Endpoint::Match
#
module Yelp
  module Fusion
    module Endpoint
      # Class for requests to find matching businesses
      class Match
        PATH = '/v3/businesses/matches'.freeze

        def initialize(client)
          @client = client
        end

        # Make a request to the business endpoint
        #
        # @param params [Hash] a hash of the required location parameters
        # @return [Response::Match] a parsed object of the response.
        #   For a complete sample response visit:
        #   https://www.yelp.com/developers/documentation/v3/business_match
        #
        # @example Search for business with params
        #   params = { name: 'swissbakers', address1:
        #   '168 Western Ave', city: 'allston', state:
        #   'MA', country: 'US' }
        #   response = client.mathc(params)
        #   response.businesses # [<Business 1>, <Business 2>, <Business 3>]
        #   response.businesses[0].name # 'Yelp'
        def match(params = {})
          Responses::Match.new(JSON.parse(match_request(params).body))
        end

        private

        def match_request(params = {})
          result = @client.connection.get(PATH, params)
          Error.check_for_error(result)
          result
        end
      end
    end
  end
end