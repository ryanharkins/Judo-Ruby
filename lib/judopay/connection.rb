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
      options = {
        :headers => request_headers,
        :url => Judopay.configuration.endpoint_url,
        :ssl => {
          :ca_file => File.dirname(File.dirname(__FILE__)) + '/certs/digicert_sha256_ca.pem',
          :cert_store => false,
          :verify => true
        }
      }

      connection = Faraday::Connection.new(options) do |faraday|
        faraday.adapter :httpclient
        faraday.use Faraday::Request::UrlEncoded
        faraday.use Faraday::Response::Logger, Judopay.configuration.logger
        faraday.use FaradayMiddleware::JudoMashify unless raw
        unless raw
          case Judopay.configuration.format.to_s
          when 'json' then faraday.use Faraday::Response::ParseJson
          end
        end
        faraday.use FaradayMiddleware::RaiseHttpException
      end

      # Authentication with basic auth if there is no OAuth2 access token
      if Judopay.configuration.oauth_access_token.nil?
        connection.basic_auth(
          Judopay.configuration.api_token,
          Judopay.configuration.api_secret
        )
        Judopay.log(Logger::DEBUG, 'Using HTTP basic auth')
      end

      connection
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
