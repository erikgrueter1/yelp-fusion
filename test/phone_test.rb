require_relative 'test_helper'
require 'pry-coolline'
require 'vcr'

class PhoneTest < Minitest::Test
  def setup
    api_key = 'sample_api_key'
    phone = '+14159083801'
    @client = Yelp::Fusion::Client.new(api_key)
    @phone = Yelp::Fusion::Endpoint::Phone.new(@client)
    @results = VCR.use_cassette('phone') do
      @phone.phone_search(phone)
    end
    @first = @results.businesses.first
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

  def test_phone_search_returns_data
    assert_operator @results.businesses.size, :>, 0
  end

  def test_phone_search_is_correct_type
    assert_kind_of Yelp::Fusion::Responses::Phone, @results
  end

  def test_phone_search_variables_not_nil
    instance_vars = instance_mapping(@first)
    attribute_assertion(instance_vars)
  end

  def test_phone_is_not_nil_after_search
    coordinates = @first.instance_variable_get(:@coordinates)
    instance_vars = instance_mapping(coordinates)
    attribute_assertion(instance_vars)
  end

  def test_phone_coordiantes_is_not_nil_after_search
    location = @first.instance_variable_get(:@location)
    instance_vars = instance_mapping(location)
    attribute_assertion(instance_vars)
  end

  def test_phone_categories_is_not_nil_after_search
    categories = @first.instance_variable_get(:@categories)
    instance_vars = instance_mapping(categories)
    attribute_assertion(instance_vars)
  end

  def test_phone_results_is_not_zero
    assert @results.total > 0
  end
end