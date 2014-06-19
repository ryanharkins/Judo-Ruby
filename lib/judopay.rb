require_relative 'judopay/version'
require_relative 'judopay/api'
require_relative 'judopay/payment'
require_relative 'judopay/transaction'
require_relative 'judopay/response'

module Judopay
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :api_version, 
                  :api_token,
                  :api_secret,
                  :format, 
                  :endpoint_url,
                  :user_agent,
                  :judo_id

    def initialize
      # Set defaults
      @api_version = '4.0.0'
      @format = 'json'
      @endpoint_url = 'https://partnerapi.judopay-sandbox.com'
      @user_agent = 'Judopay Ruby SDK gem v' + Judopay::VERSION
    end
  end
end
