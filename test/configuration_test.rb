require 'pry-coolline'
require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_config_key_is_configuration_type
    sample_api_key = 'thisIsAnAPITestKey'
    config = Yelp::Fusion::Configuration.new(sample_api_key)
    assert_kind_of Yelp::Fusion::Configuration, config
  end

  def test_create_instance_of_yelp_configuration_with_bad_key
    sample_api_key = 12345
    config = Yelp::Fusion::Configuration.new(sample_api_key)
    assert_nil config.api_key
  end

  def test_create_instance_of_yelp_configuration_with_good_key
    sample_api_key = '12345'
    config = Yelp::Fusion::Configuration.new(sample_api_key)
    assert_equal config.api_key, sample_api_key
  end
end