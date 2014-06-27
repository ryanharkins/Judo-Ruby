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
          raise Judopay::BadRequest.new(response)
        when 401
        when 403
          raise Judopay::NotAuthorized.new(response)
        when 404
          raise Judopay::NotFound.new(response)
        when 409
          raise Judopay::Conflict.new(response)
        when 500
          raise Judopay::InternalServerError.new(response)
        when 502
          raise Judopay::BadGateway.new(response)
        when 503
          raise Judopay::ServiceUnavailable.new(response)
        when 504
          raise Judopay::GatewayTimeout.new(response)
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

  end
end