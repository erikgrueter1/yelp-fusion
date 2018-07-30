# Copyright (c) Jobcase, Inc. All rights reserved.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require_relative 'test_helper'
require 'pry-coolline'
require 'vcr'

class SearchTest < Minitest::Test
  def setup
    api_key = 'api_placeholder'
    @client = Yelp::Fusion::Client.new(api_key)
    @results = VCR.use_cassette('search') do
      @client.search('San Francisco')
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

  def test_search_is_initializing
    json = { 'a' => 10, 'b' => 20 }
    search_endpoint = Yelp::Fusion::Endpoint::Search.new(json)
    assert_kind_of Yelp::Fusion::Endpoint::Search, search_endpoint
  end

  def test_search_returns_data
    assert_operator @results.businesses.size, :>, 0
  end

  def test_search_is_correct_type
    assert_kind_of Yelp::Fusion::Responses::Search, @results
  end

  def test_search_by_coordinates_returns_search_object
    coordinates = { latitude: 37.6, longitude: 38.6 }
    coord_results = VCR.use_cassette('search_by_coordinates') do
      @client.search_by_coordinates(coordinates)
    end
    assert_kind_of Yelp::Fusion::Responses::Search, coord_results
  end

  def test_broad_search_variables_not_nil
    instance_vars = instance_mapping(@first)
    attribute_assertion(instance_vars)
  end

  def test_each_instance_variable_of_businesses_is_not_nil_after_search
    business = @first.instance_variable_get(:@business)
    instance_vars = instance_mapping(business)
    attribute_assertion(instance_vars)
  end

  def test_each_instance_variable_of_location_is_not_nil_after_search
    location = @first.instance_variable_get(:@location)
    instance_vars = instance_mapping(location)
    attribute_assertion(instance_vars)
  end

  def test_each_instance_variable_of_categories_is_not_nil_after_search
    categories = @first.instance_variable_get(:@categories)
    instance_vars = instance_mapping(categories)
    attribute_assertion(instance_vars)
  end

  def test_each_instance_variable_of_region_is_not_nil_after_search
    region = @results.region
    instance_vars = instance_mapping(region)
    attribute_assertion(instance_vars)
  end

  def test_total_results_is_not_zero
    assert @results.total > 0
  end
end