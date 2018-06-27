require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/categories'
require 'yelp/fusion/responses/models/location'
require 'yelp/fusion/responses/models/hours'

module Yelp
  module Fusion
    module Responses
      module Models
        class Business < Responses::Base
          attr_reader :categories, :coordinates, :display_phone,
                      :distance, :id,
                      :alias, :image_url, :is_closed, :location,
                      :name, :phone, :price,
                      :rating, :review_count, :url, :transactions,
                      :hours, :is_claimed, :photos
          def initialize(json)
            super(json)
            @categories = parse(@categories, Categories)
            @location = parse(@location, Location)
            @hours = parse(@hours, Hours)
            @coordinates = parse(@coordinates, Center)
          end
        end
      end
    end
  end
end