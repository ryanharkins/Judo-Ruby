require_relative '../lib/judopay'
require 'i18n'

require 'factory_girl'
require 'factories'
require 'webmock/rspec'

# Added to counter deprecation warning
I18n.enforce_available_locales = true

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include WebMock::API

  config.expect_with :rspec do |c|
    c.syntax = [:expect, :should]
  end
end

# Use Judopay default configuration
Judopay.configure

def stub_get(path)
  stub_request(:get, /judopay/i)
end

def stub_post(path)
  stub_request(:post, /judopay/i)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
