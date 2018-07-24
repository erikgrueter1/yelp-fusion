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
    @results = VCR.use_cassette('match') do
      @client.match(params)
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