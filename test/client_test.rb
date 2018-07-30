# Copyright (c) Jobcase, Inc. All rights reserved

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
require 'faraday'
require 'faraday_middleware'
require 'pry-coolline'

class ClientTest < Minitest::Test
  def setup
    @client = Yelp::Fusion::Client.new
  end

  def test_create_instance_of_yelp_client
    @client
  end

  def test_client_object_type_matches
    client_initialize = Yelp::Fusion::Client.new('api_key')
    assert_kind_of Yelp::Fusion::Client, client_initialize
    assert_kind_of Yelp::Fusion::Configuration, client_initialize.configuration
  end

  def test_create_instance_of_yelp_client_with_good_key
    client_initialize = Yelp::Fusion::Client.new('api_key')
    assert_equal client_initialize.configuration.api_key, 'api_key'
  end

  def test_configure_adds_key
    config = @client.configure do |c|
      c.api_key = 'api_key'
    end
    assert_equal config.api_key, 'api_key'
  end

  def test_does_not_pass_api_key_test
    api_key = nil
    assert_raises Yelp::Fusion::Error::MissingAPIKeys do
      Yelp::Fusion::Client.new.configure do |c|
        c.api_key = api_key
      end
    end
  end

  def test_with_already_initialized_configuration
    client_initialize = Yelp::Fusion::Client.new('api_key')
    assert_raises Yelp::Fusion::Error::AlreadyConfigured do
      client_initialize.configure do |c|
        c.api_key = 'api_key'
      end
    end
  end

  def test_if_configuration_is_frozen
    config = @client.configure do |c|
      c.api_key = 'api_key'
    end
    assert_raises RuntimeError do
      config.api_key = 'not_api_key'
    end
  end

  def test_if_returns_if_connection_is_defined
    client = Yelp::Fusion::Client.new('api_key')
    connection_one = client.connection
    connection_two = client.connection
    assert_equal connection_one, connection_two
  end

  def test_needs_api_key
    assert_raises Yelp::Fusion::Error::MissingAPIKeys do
      @client.connection
    end
  end

  def test_if_responds_to_search_method
    client = Yelp::Fusion::Client.new('api_key')
    assert client.respond_to?(:search)
  end

  def test_if_responds_to_bussines_method
    client = Yelp::Fusion::Client.new('api_key')
    assert client.respond_to?(:business)
  end

  def test_if_responds_to_phone_search_method
    client = Yelp::Fusion::Client.new('api_key')
    assert client.respond_to?(:phone_search)
  end
end
