require 'test_helper'
require 'pry-coolline'

class VersionTest < Minitest::Test
  def test_the_yelp_version_can_be_obtained
    refute_empty Yelp::Fusion::VERSION
    assert_equal true, Yelp::Fusion::VERSION.is_a?(String)
  end
end