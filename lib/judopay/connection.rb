require 'faraday'
require 'faraday_middleware'
require 'openssl'
require_relative '../faraday/raise_http_exception'
require_relative '../faraday/judo_mashify'

module Judopay
  # @private
  module Connection
    private

    def connection(raw = false)
      connection = Faraday.new(default_connection_options) do |faraday|
        faraday.use Faraday::Request::UrlEncoded
        faraday.use Faraday::Response::Logger, Judopay.configuration.logger
        define_format(faraday, raw)
        faraday.use FaradayMiddleware::RaiseHttpException
        # When adapter set to "httpclient" SSL error emerges after bunch of requests:
        # "Faraday::SSLError: SSL_connect SYSCALL returned=5 errno=0 state=SSLv2/v3 read server hello A"
        faraday.adapter :net_http
      end

      define_auth(connection)
    end

    def define_format(faraday, raw)
      return if raw
      faraday.use FaradayMiddleware::JudoMashify
      faraday.use Faraday::Response::ParseJson if Judopay.configuration.format.to_s == 'json'
    end

    def define_auth(connection)
      # Authentication with basic auth if there is no OAuth2 access token
      if Judopay.configuration.oauth_access_token.nil?
        Judopay.configuration.validate
        connection.basic_auth(
          Judopay.configuration.api_token,
          Judopay.configuration.api_secret
        )
        Judopay.log(Logger::DEBUG, 'Using HTTP basic auth')
      end

      connection
    end

    def default_connection_options
      {
        :headers => request_headers,
        :url => Judopay.configuration.endpoint_url,
        :ssl => {
          :ca_file => File.dirname(File.dirname(__FILE__)) + '/certs/rapidssl_ca.crt',
          :cert_store => false,
          :verify => true
        }
      }
    end

    def request_headers
      format = Judopay.configuration.format

      headers = {
        'Accept' => "application/#{format}; charset=utf-8",
        'User-Agent' => Judopay.configuration.user_agent,
        'API-Version' => Judopay.configuration.api_version,
        'Content-Type' => 'application/json'
      }

      # Do we have an OAuth2 access token?
      unless Judopay.configuration.oauth_access_token.nil?
        headers['Authorization'] = 'Bearer ' + Judopay.configuration.oauth_access_token
        Judopay.log(Logger::DEBUG, 'Using OAuth2 access token')
      end

      headers
    end
  end
end
