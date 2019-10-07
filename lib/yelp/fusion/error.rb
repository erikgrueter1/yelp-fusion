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

# Yelp::Fusion::Error::ResponseValidator
module Yelp
  module Fusion
    # Module to handle errors in Gem
    module Error
      # Class to handle error responses
      class ResponseValidator
        # If the request is not successful, raise an appropriate Yelp::Error
        # exception with the error text from the request response.
        # @param response from the Yelp API
        def validate(response)
          return if successful_response?(response)

          raise error_from_response(response)
        end

        private

        def successful_response?(response)
          # check if the status is in the range of non-error status codes
          (200..399).cover?(response.status)
        end

        # Create an initialized exception from the response
        # @return [Yelp::Error::Base] exception corresponding to API error
        def error_from_response(response)
          body = JSON.parse(response.body)
          klass = error_classes[body['error']['code']]
          klass.new(body['error']['description'], body['error'])
        end

        # Maps from API Error id's to Yelp::Error exception classes.
        def error_classes
          @error_classes ||= Hash.new do |hash, key|
            class_name = key.split('_').map(&:capitalize).join('')
            hash[key] = Yelp::Fusion::Error.const_get(class_name)
          end
        end
      end

      # Check the response for errors, raising an appropriate exception if
      # necessary
      # @param (see ResponseValidator#validate)
      def self.check_for_error(response)
        @response_validator ||= ResponseValidator.new
        @response_validator.validate(response)
      end

      # Standard error response class
      class Base < StandardError
        def initialize(msg, _error = nil)
          super(msg)
        end
      end

      # Class to handle an already configure Yelp Client
      class AlreadyConfigured < Base
        def initialize(msg = 'Gem cannot be reconfigured.  Initialize a new ' \
          'instance of Yelp::Client.', error = nil)
          super
        end
      end

      # Class for missing Yelp API Keys
      class MissingAPIKeys < Base
        def initialize(msg = "You're missing an API key", error = nil)
          super
        end
      end

      # Class for missing Latitude or longitude
      class MissingLatLng < Base
        def initialize(msg = 'Missing required latitude '\
          'or longitude parameters', error = nil)
          super
        end
      end

      # Class for invalid Auth Token
      class TokenInvalid < Base; end
      # Class if no Yelp Location is found
      class LocationNotFound < Base; end
      # Class if the rate limit is exceeded
      class TooManyRequestsPerSecond < Base; end
      # Class if Yelp experiences a internal error
      class InternalError < Base; end
      # Class if a Validation Error occurs
      class ValidationError < Base; end
      # Class if an auth token is missing
      class TokenMissing < Base; end
      # Class for timed out requests
      class RequestTimedOut < Base; end
      # Class if the access limit for requests
      # is reached
      class AccessLimitReached < Base; end
      # Class for resources not found
      class NotFound < Base; end
      # Class for client erro
      class ClientError < Base; end
      # Class if businesses are not found
      class BusinessNotFound < Base; end
    end
  end
end