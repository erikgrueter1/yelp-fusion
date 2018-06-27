module Yelp
  module Fusion
    module Responses
      module Models
        class Categories < Responses::Base
          attr_reader :alias, :title
          def initialize(json)
            super(json)
          end
        end
      end
    end
  end
end