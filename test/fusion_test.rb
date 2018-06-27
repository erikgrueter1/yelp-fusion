require_relative 'test_helper'
require 'pry-coolline'

class FusionTest < Minitest::Test
  def test_if_configured
    configuration = Yelp::Fusion.client.configure do |config|
      config.api_key = 'abc'
    end
    assert_kind_of Yelp::Fusion::Configuration, configuration
  end
end