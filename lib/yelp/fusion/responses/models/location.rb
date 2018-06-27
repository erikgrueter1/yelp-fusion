module Yelp
  module Fusion
    module Responses
      module Models
        class Location < Responses::Base
          attr_reader :city, :country, :address2, :address3,
                      :state, :address1, :zip_code,
                      :cross_streets, :display_address
          def initialize(json)
            super(json)
          end
        end
      end
    end
  end
end