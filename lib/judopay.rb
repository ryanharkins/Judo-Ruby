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
    self.configure_endpoint_for_environment
  end

  # Record a new log message if a logger is configured
  def self.log(log_level, message)
    logger = self.configuration.logger
    return unless logger.is_a?(Logger)
    logger.progname = 'judopay'
    logger.add(log_level) { message }
  end

  # Based on the use_production flag, which endpoint should we use?
  def self.configure_endpoint_for_environment
    if self.configuration.use_production === true
      self.configuration.endpoint_url = self.configuration.api_endpoints[:production]
    else
      self.configuration.endpoint_url = self.configuration.api_endpoints[:sandbox]      
    end
  end

  class Configuration
    attr_accessor :api_version, 
                  :api_token,
                  :api_secret,
                  :oauth_access_token,
                  :format, 
                  :endpoint_url,
                  :user_agent,
                  :judo_id,
                  :logger,
                  :use_production

    attr_reader   :api_endpoints

    def initialize
      # Set defaults
      @api_version = '4.0.0'
      @format = 'json'
      @use_production = false
      @user_agent = 'Judopay Ruby SDK gem v' + Judopay::VERSION
      @logger = Judopay::NullLogger.new
      @api_endpoints = {
        :sandbox => 'https://partnerapi.judopay-sandbox.com',
        :production => 'https://production.local'
      }.freeze
      @endpoint_url = @api_endpoints[:sandbox]
    end
  end
end
