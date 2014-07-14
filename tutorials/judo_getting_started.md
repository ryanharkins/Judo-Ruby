# Getting started - Ruby

[Include standard create account/getting started sections]

## Installation

The Judopay gem supports Ruby 1.9.3 and above (including 2.0.x and 2.1.x).

Add this line to your application's Gemfile:

    gem 'judopay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install judopay

## Dependencies

These will all be automatically installed for you when you install the Judopay gem.

### virtus
https://github.com/solnic/virtus
Provides a common API for defining attributes on a model

### httpclient
https://github.com/nahi/httpclient
HTTP client adaptor used by Faraday

### activemodel
https://github.com/rails/rails/tree/master/activemodel
Provides pre-request validation of user input

### faraday
https://github.com/lostisland/faraday
Simple, but flexible HTTP client library

### rash
https://github.com/tcocca/rash
Extension to Hashie::Mash to convert all keys in the hash to underscore

### addressable
https://github.com/sporkmonger/addressable
Used for generation of URIs

# Configuration

You configure the Judopay gem by passing a block. For example:

Judopay.configure do |config|
	config.judo_id = 12345
end

# Authentication
You can authenticate either with basic authentication by passing your login and password credentials or using an existing OAuth2 access token.

### Basic authentication

Judopay.configure do |config|
	config.judo_id = 12345
	config.api_token = 'your-token'
  config.api_secret = 'your-secret'
end

### OAuth2 access token authentication

Judopay.configure do |config|
	config.judo_id = 12345
	config.oauth_access_token = 'your-oauth-token'
end

