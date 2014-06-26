require 'faraday'
require 'faraday_middleware'
require_relative '../faraday/raise_http_exception'
require_relative '../faraday/judo_mashify'

module Judopay
  # @private
  module Connection
    private

    def connection(raw = false)
      format = Judopay.configuration.format
      options = {
        :headers => {
          'Accept' => "application/#{format}; charset=utf-8",
          'User-Agent' => Judopay.configuration.user_agent,
          'API-Version' => Judopay.configuration.api_version,
          'Content-Type' => 'application/json'
        },
        :url => Judopay.configuration.endpoint_url
      }

      connection = Faraday::Connection.new(options) do |faraday|
        faraday.adapter :httpclient
        faraday.use Faraday::Request::UrlEncoded
        # faraday.use Faraday::Response::Logger
        faraday.use FaradayMiddleware::JudoMashify unless raw
        unless raw
          case Judopay.configuration.format.to_s
          when 'json' then faraday.use Faraday::Response::ParseJson
          end
        end
        faraday.use FaradayMiddleware::RaiseHttpException
      end

      connection.basic_auth(
        Judopay.configuration.api_token,
        Judopay.configuration.api_secret
      )
      connection
    end
  end
end
