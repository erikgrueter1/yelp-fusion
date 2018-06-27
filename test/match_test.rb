require 'test_helper'
require 'pry-coolline'
require 'minitest/autorun'
require 'vcr'

class MatchTest < Minitest::Test
  def setup
    api_key = 'api_placeholder'
    params = { name: 'swissbakers', address1: '168 Western Ave',
               city: 'allston', state: 'MA', country: 'US' }
    @client = Yelp::Fusion::Client.new(api_key)
    @match = Yelp::Fusion::Endpoint::Match.new(@client)
    @results = VCR.use_cassette('match') do
      @match.match(params)
    end
    @attributes = @results.businesses.first
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

  def test_match_is_initializing
    match_endpoint = Yelp::Fusion::Endpoint::Match.new('id')
    assert_kind_of Yelp::Fusion::Endpoint::Match, match_endpoint
  end

  def test_match_is_correct_type
    assert_kind_of Yelp::Fusion::Responses::Match, @results
  end

  def test_broad_match_variables_not_nil
    instance_vars = instance_mapping(@attributes)
    attribute_assertion(instance_vars)
  end

  def test_match_location_is_not_nil_after_search
    location = @attributes.location
    instance_vars = instance_mapping(location)
    attribute_assertion(instance_vars)
  end

  def test_match_coords_is_not_nil_after_search
    coordinates = @attributes.coordinates
    instance_vars = instance_mapping(coordinates)
    attribute_assertion(instance_vars)
  end
end