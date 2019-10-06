# Yelp::Fusion

This is a Ruby Gem for the Yelp API. It'll simplify the process of consuming data from the Yelp API for developers using Ruby. The library encompasses both Search and Business API functions.

This library is in Beta and should be used for testing purposes only.

Please remember to read and follow the [Terms of Use](https://www.yelp.com/developers/api_terms) and [display requirements](https://www.yelp.com/developers/display_requirements) before creating your applications.


## Installation

Add this line to your Rails application's Gemfile:

```ruby
gem 'yelp-fusion', '0.2.1-beta'
```

Add this line to your Ruby appliation's Gemfile:

```ruby
gem 'yelp-fusion', require: 'yelp/fusion'
```


And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yelp-fusion --pre

## Usage

### Basic Usage

The gem uses a client model to query against the API. You create and configure a client with your API keys and make requests through that.

```ruby
require 'yelp/fusion'

client = Yelp::Fusion::Client.new(YOUR_API_KEY)
```

Alternatively, you can also globally configure the client using a configure
block, and access a client singleton using `Yelp::Fusion.client`.  If you intend to
use the gem with Rails, the client should be configured in an initializer.

```ruby
require 'yelp/fusion'

configuration = Yelp::Fusion.client.configure do |config|
  config.api_key = YOUR_API_KEY
end

configuration.search('San Francisco', { term: 'food' })
```
After creating the client you're able to make requests to either the Search, Business, Phone, Review, Match, and Transaction API. Note: you must have an API key. If you need any keys sign up and get access from [http://www.yelp.com/developers](http://www.yelp.com/developers).

### [Search API](https://www.yelp.com/developers/documentation/v3/business_search)

Once you have a client you can use ``#search`` to make a request to the Search API.

```ruby
client.search('San Francisco')
```

You can pass options to filter your search. `client.search` expects two
arguments:

* location
* params

The location arguments match the location option in search endpoint.[Seach API](https://www.yelp.com/developers/documentation/v3/business_search)
This attribute is attached to options send to the serch endpoint.

The params are convert to a hash and send to endpoint as verbatim options.

* term: Search for term eg: 'food', 'restaurants', or the business name.
* categories:  A list of comma limited categories to filter the business search
* locale: Specify the locale to return the business information in.

Form more info and the completed list of options, please go to [Search API](https://www.yelp.com/developers/documentation/v3/business_search)

You can call search method using ruby arguments. The lisf or arguments will be
parsed as hash for the second parameter.

```ruby
# ruby arguments
client.search('San Francisco', term: 'restaurants')
```

You can also pass a hash as second argument.

```ruby
# hash params
params = {
  term: 'food',
  limit: 3,
  category_filter: 'discgolf'
}

client.search('San Francisco', params)
```

Key names and options for params and locale match the documented names on the [Yelp Search API](https://www.yelp.com/developers/documentation/v3/business_search)

Additionally there is one more search methods for searching by [geographical coordinates](https://www.yelp.com/developers/documentation/v3/business_search):

```ruby
# coordinates
coordinates = { latitude: 37.7577, longitude: -122.4376 }
client.search_by_coordinates(coordinates, params)
```

### [Business API](https://www.yelp.com/developers/documentation/v3/business)

To use the Business API after you have a client you just need to call ``#business`` with a business id

```ruby
client.business('lJAGnYzku5zSaLnQ_T6_GQ')
```

### [Phone Search API](https://www.yelp.com/developers/documentation/v3/business_search_phone)

To use the Phone Search API after you have a client you just need to call ``#phone_search`` with a phone number and make sure you use the country code.

```ruby
client.phone_search('+15555555555')
```

### [Review Details API](https://www.yelp.com/developers/documentation/v3/business_reviews)

To find all of the reviews for a business, use ``#review`` with a business ID.

```ruby
client.review('lJAGnYzku5zSaLnQ_T6_GQ')
```

### [Transaction Details API](https://www.yelp.com/developers/documentation/v3/transaction_search)

To find all of the reviews for a business, use ``#transaction`` with ``'deliver'`` and a business ID.

```ruby
client.transaction_search('delivery', {location: 'San Francisco'})
```

### [Match Details API](https://www.yelp.com/developers/documentation/v3/business_match)

To find all of the reviews for a business, use ``#match`` with a business ID.

```ruby
client.match({name: 'swissbakers', address1: '168 Western Ave', city: 'allston', state: 'MA', country: 'US'})
```

## Responses

Responses from the API are all parsed and converted into Ruby objects. You're able to access information using dot-notation

```ruby
## search
response = client.search('San Francisco')

response.businesses
# [<Business 1>, <Business 2>, ...]

response.businesses[0].name
# "Kim Makoi, DC"

response.businesses[0].rating
# 5.0


## business
response = client.business('lJAGnYzku5zSaLnQ_T6_GQ')

response.business.name
# Yelp

response.business.categories
# [["Local Flavor", "localflavor"], ["Mass Media", "massmedia"]]
```

For specific response values check out the docs for the [Search API](http://www.yelp.com/developers/documentation/v2/search_api#rValue), the [Business API](http://www.yelp.com/developers/documentation/v2/business#rValue), the [Match API](https://www.yelp.com/developers/documentation/v3/business_match), the [Phone API](https://www.yelp.com/developers/documentation/v3/business_search_phone), the [Review API](https://www.yelp.com/developers/documentation/v3/business_reviews), and the [Transaction API](https://www.yelp.com/developers/documentation/v3/transaction_search)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/erikgrueter1/yelp-fusion. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it ( https://github.com/erikgrueter1/yelp-fusion/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Our minitest test suite expects environment variables to be populated with your Yelp API Access Tokens.

You can generate and find your Access Tokens at [https://www.yelp.com/developers/manage_api_keys](https://www.yelp.com/developers/v3/manage_app).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT), Copyright (c) 2018 Jobcase, Inc

## Code of Conduct

Everyone interacting in the Yelp::Fusion project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/yelp-fusion/blob/master/CODE_OF_CONDUCT.md).
