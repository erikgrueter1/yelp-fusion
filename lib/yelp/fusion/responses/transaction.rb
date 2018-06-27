require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/business'

module Yelp
  module Fusion
    module Responses
      class Transaction < Base
        attr_reader :total, :businesses
        def initialize(json)
          super(json)
          @businesses = parse(@businesses, Models::Business)
        end
      end
    end
  end
end