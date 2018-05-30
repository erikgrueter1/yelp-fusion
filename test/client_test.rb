require 'test_helper'
require 'pry-coolline'

class ClientTest < Minitest::Test

  def test_create_instance_of_yelp_client
    Yelp::Fusion::Client.new
  end

  # need tests for configuration
  def test_create_instance_of_yelp_client_with_options
    client = Yelp::Fusion::Client.new(
      {
        consumer_key: 'CONSUMER_KEY',
        consumer_secret: 'CONSUMER_SECRET',
        token: 'TOKEN',
        token_secret: 'TOKEN_SECRET'
      }
    )

    # check which configuration keys are
    # actually needed here
    assert_equal client.consumer_key, 'CONSUMER_KEY'
    assert_equal client.consumer_secret, 'CONSUMER_SECRET'
    assert_equal client.token, 'TOKEN'
    assert_equal client.token_secret, 'TOKEN_SECRET'
  end

  def configure_instance_of_yelp_client

  end
end
