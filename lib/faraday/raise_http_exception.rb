require 'faraday'
require_relative '../judopay/error'

# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response.status.to_i
        when 400
          raise Judopay::BadRequest, response
        when 401
        when 403
          raise Judopay::NotAuthorized, response
        when 404
          raise Judopay::NotFound, response
        when 409
          raise Judopay::Conflict, response
        when 500
          raise Judopay::InternalServerError, response
        when 502
          raise Judopay::BadGateway, response
        when 503
          raise Judopay::ServiceUnavailable, response
        when 504
          raise Judopay::GatewayTimeout, response
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

  end
end