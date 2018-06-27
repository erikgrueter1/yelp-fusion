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
