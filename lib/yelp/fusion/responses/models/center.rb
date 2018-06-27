module Yelp
  module Fusion
    module Responses
      module Models
        class Center < Responses::Base
          attr_reader :latitude, :longitude
          def initialize(json)
            super(json)
          end
        end
      end
    end
  end
end