module Yelp
  module Fusion
    module Error

      class Base < StandardError
        def initialize(msg,error=nil)
          super(msg)
        end
      end

      class AlreadyConfigured < Base
        def initialize(msg = 'Gem cannot be reconfigured.  Initialize a new ' +
          'instance of Yelp::Client.', error=nil)
          super
        end 
      end

      class MissingAPIKeys < Base
        def initialize(msg = "You're missing an API key", error=nil)
          super
        end
      end

    end
  end
end