require 'test/unit'
require 'judopay'
require 'judopay/error'
require 'factory_girl'
require_relative '../../spec/factories'
require_relative '../helper/assertion_helper'

class IntegrationBase < Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
  include TestHelpers

  def setup
    Judopay.configure do |config|
      config.judo_id = ENV['JUDO_API_ID']
      config.api_token = ENV['JUDO_API_TOKEN']
      config.api_secret = ENV['JUDO_API_SECRET']
      config.use_production = false
    end
  end
end
