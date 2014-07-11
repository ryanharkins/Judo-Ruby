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
          fail Judopay::BadRequest, response
        when 401, 403
          fail Judopay::NotAuthorized, response
        when 404
          fail Judopay::NotFound, response
        when 409
          fail Judopay::Conflict, response
        when 500
          fail Judopay::InternalServerError, response
        when 502
          fail Judopay::BadGateway, response
        when 503
          fail Judopay::ServiceUnavailable, response
        when 504
          fail Judopay::GatewayTimeout, response
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end
  end
end
