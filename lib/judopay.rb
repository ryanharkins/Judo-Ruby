require_relative 'judopay/version'
require_relative 'judopay/api'
require_relative 'judopay/response'
require_relative 'judopay/serializer'
require_relative 'judopay/error'
require_relative 'judopay/null_logger'

module Judopay
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  # Record a new log message if a logger is configured
  def self.log(log_level, message)
    logger = self.configuration.logger
    return unless logger.is_a?(Logger)
    logger.progname = 'judopay'
    logger.add(log_level) { message }
  end

  class Configuration
    attr_accessor :api_version, 
                  :api_token,
                  :api_secret,
                  :format, 
                  :endpoint_url,
                  :user_agent,
                  :judo_id,
                  :logger

    def initialize
      # Set defaults
      @api_version = '4.0.0'
      @format = 'json'
      @endpoint_url = 'https://partnerapi.judopay-sandbox.com'
      @user_agent = 'Judopay Ruby SDK gem v' + Judopay::VERSION
      @logger = Judopay::NullLogger.new
    end
  end
end
