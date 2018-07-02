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

require 'simplecov'
SimpleCov.start

require 'yelp/fusion'
require 'yelp/fusion/client'
require 'yelp/fusion/configuration'
require 'yelp/fusion/version'
require 'yelp/fusion/error'
require 'yelp/fusion/responses/base'
require 'yelp/fusion/responses/phone'
require 'yelp/fusion/responses/search'
require 'yelp/fusion/responses/match'
require 'yelp/fusion/responses/review'
require 'yelp/fusion/responses/business'
require 'yelp/fusion/responses/transaction'
require 'yelp/fusion/responses/models/business'
require 'yelp/fusion/responses/models/reviews'
require 'yelp/fusion/responses/models/user'
require 'yelp/fusion/responses/models/categories'
require 'yelp/fusion/responses/models/location'
require 'yelp/fusion/responses/models/hours'
require 'yelp/fusion/responses/models/region'
require 'yelp/fusion/responses/models/openHours'
require 'yelp/fusion/responses/models/center'
require 'yelp/fusion/endpoint/match'
require 'yelp/fusion/endpoint/search'
require 'yelp/fusion/endpoint/business'
require 'yelp/fusion/endpoint/transaction'
require 'yelp/fusion/endpoint/phone'
require 'yelp/fusion/endpoint/review'
require 'minitest/autorun'
require 'minitest/pride'
require 'vcr'
require 'rubocop'
require 'json'

$VERBOSE = nil

VCR.configure do |config|
  config.cassette_library_dir = 'Test::vcr_casettes'
  config.hook_into :webmock
end
