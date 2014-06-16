require 'faraday'
require 'faraday_middleware'
require_relative '../faraday/raise_http_exception'

module Judopay
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {
          'Accept' => "application/#{Judopay.configuration.format}; charset=utf-8", 
          'User-Agent' => Judopay.configuration.user_agent,
          'API-Version' => Judopay.configuration.api_version,
          'Content-Type' => 'application/json'          
        },
        :url => Judopay.configuration.endpoint_url
      }
      
      connection = Faraday::Connection.new(options) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.use Faraday::Request::UrlEncoded
        #faraday.use Faraday::Response::Logger
        faraday.use Faraday::Response::Rashify unless raw
        unless raw
          case Judopay.configuration.format.to_s
          when 'json' then faraday.use Faraday::Response::ParseJson
          end
        end
        faraday.use FaradayMiddleware::RaiseHttpException
      end
      
      connection.basic_auth(Judopay.configuration.api_token, Judopay.configuration.api_secret)
      connection
    end
  end
end