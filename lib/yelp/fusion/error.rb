require 'json'

module Yelp
  module Fusion
    module Error
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
          @@error_classes ||= Hash.new do |hash, key|
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

      class Base < StandardError
        def initialize(msg, _error = nil)
          super(msg)
        end
      end

      class AlreadyConfigured < Base
        def initialize(msg = 'Gem cannot be reconfigured.  Initialize a new ' \
          'instance of Yelp::Client.', error = nil)
          super
        end
      end

      class MissingAPIKeys < Base
        def initialize(msg = "You're missing an API key", error = nil)
          super
        end
      end

      class MissingLatLng < Base
        def initialize(msg = 'Missing required latitude '\
          'or longitude parameters', error = nil)
          super
        end
      end

      class TokenInvalid < Base; end
      class LocationNotFound < Base; end
      class TooManyRequestsPerSecond < Base; end
      class InternalError < Base; end
      class ValidationError < Base; end
      class TokenMissing < Base; end
      class RequestTimedOut < Base; end
      class AccessLimitReached < Base; end
      class NotFound < Base; end
      class ClientError < Base; end
    end
  end
end
