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

        def transaction_search(transaction_type, location)
          result = transaction_request(transaction_type, location)
          Responses::Transaction.new(JSON.parse(result.body))
        end

        def transaction_by_coordinates(transaction_type, coordinates)
          raise Error::MissingLatLng if coordinates[:latitude].nil? ||
                                        coordinates[:longitude].nil?
          result = transaction_request(transaction_type, coordinates)
          Responses::Transaction.new(JSON.parse(result.body))
        end

        private

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