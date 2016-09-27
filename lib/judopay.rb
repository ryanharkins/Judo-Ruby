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

  # Configure the gem by passing a block
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
    configure_endpoint_for_environment
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
    self.configuration.endpoint_url = if self.configuration.use_production
                                        self.configuration.api_endpoints[:production]
                                      else
                                        self.configuration.api_endpoints[:sandbox]
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

    attr_reader :api_endpoints

    # Set sensible configuration defaults
    def initialize
      @api_version = Judopay::API_VERSION
      @format = 'json'
      @use_production = false
      @user_agent = "Judopay Ruby (#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}) SDK gem v#{Judopay::SDK_VERSION}"
      @logger = Judopay::NullLogger.new
      @api_endpoints = {
        :sandbox => 'https://gw1.judopay-sandbox.com',
        :production => 'https://gw1.judopay.com'
      }.freeze
      @endpoint_url = @api_endpoints[:sandbox]
    end

    def validate
      return true unless judo_id.to_s.empty? || api_token.to_s.empty? || api_secret.to_s.empty?
      raise Judopay::ValidationError, 'SDK configuration variables missing'
    end
  end
end
