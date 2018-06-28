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

require 'yelp/fusion/responses/review'

module Yelp
  module Fusion
    module Endpoint
      class Review
        PATH = '/v3/businesses/'.freeze

        def initialize(client)
          @client = client
        end

        # Make a request to the business endpoint on the API
        #
        # @param id [String] the business id
        # @param locale [Hash] a hash of supported locale-related parameters
        # @return [Response::Review] the parsed response object from the API
        #
        # @example Get Review
        #   id = 'xAG4O7l-t1ubbwVAlPnDKg'
        #   locale = { lang: 'fr' }
        #   response = client.review(id, locale)
        #   response.name # => 'Yelp'
        #   response.url  # => 'http://www.yelp.com/biz/yelp-san-francisco'
        def review(id, locale = {})
          Responses::Review.new(JSON.parse(review_request(id, locale).body))
        end

        private

        # Make a request to the review endpoint of the API
        # The endpoint requires a format of v3/businesses/{id}/reviews
        # so the primary request parameter is concatenated. After getting
        # the response back it's checked to see if there are any API errors
        # and raises the relevant one if there is.
        #
        # @param id [String] the business id
        # @param locale [Hash] a hash of supported locale-related parameters
        # @return [Faraday::Response] the raw response back from the connection
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