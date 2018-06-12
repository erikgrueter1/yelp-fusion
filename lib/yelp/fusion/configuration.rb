module Yelp
  module Fusion
    class Configuration

      attr_accessor :api_key

      # Creates the configuration
      # @param [config_api] String containing configuration parameter and its value
      # @return [Configuration] a new configuration with the value from the
      # config_api String
      def initialize(config_api = nil)
        if (!config_api.nil?) && config_api.is_a?(String)
          self.api_key = config_api
        end
      end
    end
  end
end