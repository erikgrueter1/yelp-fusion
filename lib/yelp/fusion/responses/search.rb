require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/business'
require 'yelp/fusion/responses/models/region'

module Yelp
  module Fusion
    module Responses
      class Search < Base
        attr_reader :businesses, :region, :total
        def initialize(json)
          super(json)
          @businesses = parse(@businesses, Models::Business)
          @region     = parse(@region, Models::Region)
        end
      end
    end
  end
end