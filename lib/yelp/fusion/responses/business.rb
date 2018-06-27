require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/business'

module Yelp
  module Fusion
    module Responses
      class Business < Base
        attr_reader :business
        def initialize(json)
          super(business)
          @business = parse(json, Models::Business)
        end
      end
    end
  end
end