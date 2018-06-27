require_relative 'test_helper'
require 'pry-coolline'

class BaseTest < Minitest::Test
  def test_base_returns_yelp_fusion_responses_base
    base = Yelp::Fusion::Responses::Base.new(nil)
    assert_kind_of Yelp::Fusion::Responses::Base, base
  end

  def test_returns_if_json_is_nil
    base = Yelp::Fusion::Responses::Base.new(nil)
    a = base.instance_variable_get(:@a)
    assert_nil a
  end

  def test_instance_initialized
    json = { 'a' => 10, 'b' => 20 }
    base = Yelp::Fusion::Responses::Base.new(json)
    a = base.instance_variable_get(:@a)
    b = base.instance_variable_get(:@b)
    assert_equal a, 10
    assert_equal b, 20
  end
end