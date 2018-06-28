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

class ErrorTest < Minitest::Test
  def test_token_invalid_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(401, '{"error": {"code": '\
      '"TOKEN_INVALID", "description": '\
      '"Invalid access token or authorization header."}}')
    assert_raises Yelp::Fusion::Error::TokenInvalid do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_location_not_found_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"LOCATION_NOT_FOUND", "description": '\
      '"Could not execute search, try specifying a more exact location."}}')
    assert_raises Yelp::Fusion::Error::LocationNotFound do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_too_many_requests_per_second_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"TOO_MANY_REQUESTS_PER_SECOND", '\
      '"description": "You have exceeded the queries-per-second '\
      'limit for this endpoint. Try reducing the '\
      'rate at which you make queries."}}')
    assert_raises Yelp::Fusion::Error::TooManyRequestsPerSecond do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_internal_error_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"INTERNAL_ERROR", "description": '\
      '"Something went wrong internally, please try again later"}}')
    assert_raises Yelp::Fusion::Error::InternalError do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_validation_error_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"VALIDATION_ERROR", "description": ' \
      '"Please specify a location or a latitude and longitude"}}')
    assert_raises Yelp::Fusion::Error::ValidationError do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_token_missing_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"TOKEN_MISSING", "description": '\
      '"An access token must be supplied in order to use this endpoint."}}')
    assert_raises Yelp::Fusion::Error::TokenMissing do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_request_timed_out_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"REQUEST_TIMED_OUT", "description": '\
      '"The request timed out, please try again later. If this continues, '\
      'please create an issue on GitHub with the request you\'re making: '\
      'https://github.com/Yelp/yelp-fusion/issues"}}')
    assert_raises Yelp::Fusion::Error::RequestTimedOut do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_access_limit_reached_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"ACCESS_LIMIT_REACHED", "description": '\
      '"You\'ve reached the access limit for this client. '\
      'Please email api@yelp.com for assistance"}}')
    assert_raises Yelp::Fusion::Error::AccessLimitReached do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_missing_not_found_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": {"code": '\
      '"NOT_FOUND", "description": '\
      '"Resource could not be found."}}')
    assert_raises Yelp::Fusion::Error::NotFound do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_missing_phone_number_failure
    test_error = Struct.new(:status, :body)
    result = test_error.new(400, '{"error": '\
      '{"description": "Bad Request", "code": '\
      '"CLIENT_ERROR"}}')
    assert_raises Yelp::Fusion::Error::ClientError do
      Yelp::Fusion::Error.check_for_error(result)
    end
  end

  def test_missing_lat_lang_failure
    client = Yelp::Fusion::Client.new('api_key')
    assert_raises Yelp::Fusion::Error::MissingLatLng do
      endpoint = Yelp::Fusion::Endpoint
      endpoint::Search.new(client).search_by_coordinates({}, {})
    end
  end

  def test_missing_lang_failure
    lat_lang = { latitude: 37.786 }
    client = Yelp::Fusion::Client.new('api_key')
    assert_raises Yelp::Fusion::Error::MissingLatLng do
      endpoint = Yelp::Fusion::Endpoint
      endpoint::Search.new(client).search_by_coordinates(lat_lang, {})
    end
  end

  def test_missing_lat_failure
    lat_lang = { longitude: 37.786 }
    client = Yelp::Fusion::Client.new('api_key')
    assert_raises Yelp::Fusion::Error::MissingLatLng do
      endpoint = Yelp::Fusion::Endpoint
      endpoint::Search.new(client).search_by_coordinates(lat_lang, {})
    end
  end
end