require_relative 'test_helper'
require 'faraday'
require 'faraday_middleware'
require 'pry-coolline'

class ClientTest < Minitest::Test
  def setup
    @client = Yelp::Fusion::Client.new
  end

  def test_create_instance_of_yelp_client
    @client
  end

  def test_client_object_type_matches
    api_key = 'thisIsAnAPITestKey'
    client_initialize = Yelp::Fusion::Client.new(api_key)
    assert_kind_of Yelp::Fusion::Client, client_initialize
    assert_kind_of Yelp::Fusion::Configuration, client_initialize.configuration
  end

  def test_create_instance_of_yelp_client_with_good_key
    api_key = '12345'
    client_initialize = Yelp::Fusion::Client.new(api_key)
    assert_equal client_initialize.configuration.api_key, api_key
  end

  def test_configure_adds_key
    api_key = 'abc'
    config = @client.configure do |c|
      c.api_key = api_key
    end
    assert_equal config.api_key, api_key
  end

  def test_does_not_pass_api_key_test
    api_key = nil
    assert_raises Yelp::Fusion::Error::MissingAPIKeys do
      Yelp::Fusion::Client.new.configure do |c|
        c.api_key = api_key
      end
    end
  end

  def test_with_already_initialized_configuration
    api_key = 'abcd'
    client_initialize = Yelp::Fusion::Client.new(api_key)
    assert_raises Yelp::Fusion::Error::AlreadyConfigured do
      client_initialize.configure do |c|
        c.api_key = api_key
      end
    end
  end

  def test_if_configuration_is_frozen
    api_key = 'abc'
    config = @client.configure do |c|
      c.api_key = api_key
    end
    assert_raises RuntimeError do
      config.api_key = '1234'
    end
  end

  def test_if_returns_if_connection_is_defined
    sample_api_key = '12345'
    client = Yelp::Fusion::Client.new(sample_api_key)
    connection_one = client.connection
    connection_two = client.connection
    assert_equal connection_one, connection_two
  end

  def test_needs_api_key
    assert_raises Yelp::Fusion::Error::MissingAPIKeys do
      @client.connection
    end
  end
end