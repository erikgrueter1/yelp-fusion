require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/center'

module Yelp
  module Fusion
    module Responses
      module Models
        class Region < Responses::Base
          attr_reader :center
          def initialize(json)
            super(json)
            @center = parse(@center, Center)
          end
        end
      end
    end
  end
end