require_relative 'test_helper'
require 'pry-coolline'
require 'vcr'

class TransactionTest < Minitest::Test
  def setup
    api_key = 'sample_api_key'
    delivery = 'delivery'
    location = { location: 'San Francisco' }
    @client = Yelp::Fusion::Client.new(api_key)
    @transaction = Yelp::Fusion::Endpoint::Transaction.new(@client)
    @results = VCR.use_cassette('transaction') do
      @transaction.transaction_search(delivery, location)
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
    instance_vars = variable_set.instance_variables.map do |attribute|
      { attribute => variable_set.instance_variable_get(attribute) }
    end
  end

  def test_transaction_is_correct_type
    assert_kind_of Yelp::Fusion::Responses::Transaction, @results
  end

  def test_transaction_by_coordinates_returns_search_object
    delivery = 'delivery'
    coordinates = { latitude: 37.6, longitude: 38.6 }
    coord_results = VCR.use_cassette('transaction_by_coordinates') do
      @transaction.transaction_by_coordinates(delivery, coordinates)
    end
    assert_kind_of Yelp::Fusion::Responses::Transaction, coord_results
  end

  def test_broad_transaction_variables_not_nil
    instance_vars = instance_mapping(@first)
    attribute_assertion(instance_vars)
  end

  def test_transactionn_var_of_businesses_is_not_nil_after_search
    business = @first.instance_variable_get(:@business)
    instance_vars = instance_mapping(business)
    attribute_assertion(instance_vars)
  end

  def test_transaction_var_of_location_is_not_nil_after_search
    location = @first.instance_variable_get(:@location)
    instance_vars = instance_mapping(location)
    attribute_assertion(instance_vars)
  end

  def test_transaction_var_of_categories_is_not_nil_after_search
    categories = @first.instance_variable_get(:@categories)
    instance_vars = instance_mapping(categories)
    attribute_assertion(instance_vars)
  end

  def test_total_transactions_is_not_zero
    assert @results.total > 0
  end
end