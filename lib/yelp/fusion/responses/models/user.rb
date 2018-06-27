require 'yelp/fusion/responses/base'

module Yelp
  module Fusion
    module Responses
      module Models
        class User < Base
          attr_reader :image_url, :name
          def initialize(json)
            super(json)
          end
        end
      end
    end
  end
end