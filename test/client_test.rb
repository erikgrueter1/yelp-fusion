require 'test_helper'
require 'pry-coolline'

class ClientTest < Minitest::Test
  def setup
    @client = Yelp::Fusion::Client.new
  end

  def test_create_instance_of_yelp_client
    Yelp::Fusion::Client.new
    @client
  end

  def test_client_object_type_matches
    api_key = 'thisIsAnAPITestKey'
    client_initialize = Yelp::Fusion::Client.new(api_key)
    assert_kind_of Yelp::Fusion::Client, client_initialize
    assert_kind_of Yelp::Fusion::Configuration, client_initialize.configuration
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
  def test_create_instance_of_yelp_client_with_good_key
    api_key = '12345'
    client_initialize = Yelp::Fusion::Client.new(api_key)
    assert_equal client_initialize.configuration.api_key, api_key
  end

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
