require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/openHours'

module Yelp
  module Fusion
    module Responses
      module Models
        class Hours < Responses::Base
          attr_reader :is_open_now, :hours_type, :open
          def initialize(json)
            super(json)
            @open = parse(@open, OpenHours)
          end
        end
      end
    end
  end
end