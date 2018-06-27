module Yelp
  module Fusion
    module Responses
      module Models
        class OpenHours < Responses::Base
          attr_reader :day, :start, :end, :is_overnight
          def initialize(json)
            super(json)
          end
        end
      end
    end
  end
end