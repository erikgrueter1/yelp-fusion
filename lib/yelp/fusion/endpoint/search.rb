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

        def search(location, params = {})
          params[:location] = location

          Responses::Search.new(JSON.parse(search_request(params).body))
        end

        def search_by_coordinates(coordinates, params = {})
          raise Error::MissingLatLng if coordinates[:latitude].nil? ||
                                        coordinates[:longitude].nil?
          coordinates.merge!(params)
          Responses::Search.new(JSON.parse(search_request(coordinates).body))
        end

        private

        def search_request(params)
          result = @client.connection.get PATH, params
          Yelp::Fusion::Error.check_for_error(result)
          result
        end
      end
    end
  end
end