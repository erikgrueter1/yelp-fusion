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