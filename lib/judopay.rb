require "judopay/version"
require File.expand_path('../judopay/api', __FILE__)
require File.expand_path('../judopay/payment', __FILE__)
require File.expand_path('../judopay/transaction', __FILE__)
require File.expand_path('../judopay/response', __FILE__)


module Judopay
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :api_version, 
                  :api_token,
                  :api_secret,
                  :format, 
                  :endpoint_url,
                  :user_agent

    def initialize
      # Set defaults
      @api_version = '4.0.0'
      @format = 'json'
      @endpoint_url = 'https://partnerapi.judopay-sandbox.com'
      @user_agent = 'Judopay Ruby SDK gem v' + Judopay::VERSION
    end
  end
end
