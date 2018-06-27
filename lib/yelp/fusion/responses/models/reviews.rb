require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/models/user'

module Yelp
  module Fusion
    module Responses
      module Models
        class Reviews < Base
          attr_reader :id, :rating, :user, :text, :time_created, :url
          def initialize(json)
            super(json)
            @user = parse(@user, User)
          end
        end
      end
    end
  end
end