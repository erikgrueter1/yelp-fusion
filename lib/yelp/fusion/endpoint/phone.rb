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