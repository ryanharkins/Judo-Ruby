# Judopay Ruby SDK

The judopay gem is not actively supported by judo, but it is available here for anyone who wish to use it as a platform to develop upon. 
This gem supports Ruby 1.9.3 and above (including 2.0.x and 2.1.x).

[![Build Status](https://travis-ci.org/JudoPay/RubySdk.svg?branch=master)](https://travis-ci.org/JudoPay/RubySdk)

## Installation

Add this line to your application's Gemfile:

	gem 'judopay'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install judopay

## Configuration

You configure the Judopay gem by passing a block. For example:

	Judopay.configure do |config|
	  config.judo_id = 12345
	end

## Authentication
You can authenticate either with basic authentication by passing your login and password credentials or using an existing OAuth2 access token.

### Basic authentication

	Judopay.configure do |config|
	  config.judo_id = 12345
	  config.api_token = 'your-token'
	  config.api_secret = 'your-secret'
	  config.use_production = false    # set to true on production, defaults to false which is the sandbox
	end

### OAuth2 access token authentication

	Judopay.configure do |config|
	  config.judo_id = 12345
	  config.oauth_access_token = 'your-oauth-token'
	end
