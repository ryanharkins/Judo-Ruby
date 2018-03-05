require_relative '../lib/judopay'
require 'i18n'

require 'factory_bot'
require 'factories'
require 'webmock/rspec'

# Added to counter deprecation warning
I18n.enforce_available_locales = true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include WebMock::API

  config.expect_with :rspec do |c|
    c.syntax = [:expect, :should]
  end
end

# Mock configuration
Judopay.configure do |config|
  config.judo_id = 'id'
  config.api_token = 'token'
  config.api_secret = 'secret'
end

def stub_get(path)
  stub_request(:get, /judopay/i)
end

def stub_post(path)
  stub_request(:post, /judopay/i)
end

def fixture_path
  File.expand_path('fixtures', __dir__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
