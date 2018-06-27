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

        def phone_search(phone)
          phone_hash = { phone: phone }
          Responses::Phone.new(JSON.parse(phone_request(phone_hash).body))
        end

        private

        def phone_request(phone)
          result = @client.connection.get PATH, phone
          Error.check_for_error(result)
          result
        end
      end
    end
  end
end