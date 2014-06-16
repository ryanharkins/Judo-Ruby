require 'faraday'

module Judopay
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Judopay::API}
    VALID_OPTIONS_KEYS = [
      :api_token,
      :api_secret,
      :api_version,
      :adapter,
      :connection_options,
      :endpoint,
      :format,
      :proxy,
      :user_agent,
      :no_response_wrapper      
    ].freeze

    # By default, don't set a user access token or secret
    DEFAULT_API_TOKEN = nil
    DEFAULT_API_SECRET = nil
    DEFAULT_API_VERSION = '4.0.0'

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://partnerapi.judopay-sandbox.com/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default, don't wrap responses with meta data (i.e. pagination)
    DEFAULT_NO_RESPONSE_WRAPPER = false

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Judopay Ruby Gem #{Judopay::VERSION}".freeze

    # An array of valid request/response formats
    #
    # @note Not all methods support the XML format.
    VALID_FORMATS = [:json, :xml].freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end
  end
end