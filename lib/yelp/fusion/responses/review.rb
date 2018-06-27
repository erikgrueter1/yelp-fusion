require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/reviews'

module Yelp
  module Fusion
    module Responses
      class Review < Base
        attr_reader :reviews, :total, :possible_languages
        def initialize(json)
          super(json)
          @reviews = parse(reviews, Models::Reviews)
        end
      end
    end
  end
end