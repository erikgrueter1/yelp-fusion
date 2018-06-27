require_relative 'test_helper'
require 'pry-coolline'
require 'vcr'

class ReviewTest < Minitest::Test
  def setup
    api_key = 'api_placeholder'
    @client = Yelp::Fusion::Client.new(api_key)
    @review = Yelp::Fusion::Endpoint::Review.new(@client)
    @results = VCR.use_cassette('review') do
      @review.review('lJAGnYzku5zSaLnQ_T6_GQ')
    end
    @attributes = @results.reviews.first
  end

  def attribute_assertion(instance_vars)
    instance_vars.each do |attribute|
      tf = (attribute.value? '')
      assert tf != true
    end
  end

  def instance_mapping(variable_set)
    variable_set.instance_variables.map do |attribute|
      { attribute => variable_set.instance_variable_get(attribute) }
    end
  end

  def test_review_is_initializing
    review_endpoint = Yelp::Fusion::Endpoint::Review.new('id')
    assert_kind_of Yelp::Fusion::Endpoint::Review, review_endpoint
  end

  def test_broad_review_variables_not_nil
    instance_vars = instance_mapping(@attributes)
    attribute_assertion(instance_vars)
  end

  def test_review_user_is_not_nil_after_search
    user = @attributes.user
    instance_vars = instance_mapping(user)
    attribute_assertion(instance_vars)
  end

  def test_total_greater_than_zero
    total = @results.total
    assert total > 0
  end
end