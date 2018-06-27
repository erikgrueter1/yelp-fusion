module Yelp
  module Fusion
    module Responses
      class Base
        # yelp returns its data in JSON form/language
        def initialize(json)
          return if json.nil?
          json.each do |key, value|
            instance_variable_set("@#{key}", value)
          end
        end

        private

        def parse(json, klass)
          return json.collect { |j| klass.new(j) } if json.is_a?(Array)
          return klass.new(json) if json
          nil
        end
      end
    end
  end
end