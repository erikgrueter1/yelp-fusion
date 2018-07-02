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

class ConfigurationTest < Minitest::Test
  def test_config_key_is_configuration_type
    sample_api_key = 'thisIsAnAPITestKey'
    config = Yelp::Fusion::Configuration.new(sample_api_key)
    assert_kind_of Yelp::Fusion::Configuration, config
  end

  def test_create_instance_of_yelp_configuration_with_bad_key
    sample_api_key = 12_345
    config = Yelp::Fusion::Configuration.new(sample_api_key)
    assert_nil config.api_key
  end

  def test_create_instance_of_yelp_configuration_with_good_key
    sample_api_key = '12345'
    config = Yelp::Fusion::Configuration.new(sample_api_key)
    assert_equal config.api_key, sample_api_key
  end
end