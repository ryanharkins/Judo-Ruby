require 'faraday'
require_relative '../judopay/error'

# @private
module FaradayMiddleware
  # Raise an appropriate exception for failure HTTP response codes
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        raise Judopay::APIError.factory(response) unless response.status.to_i == 200
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end
  end
end
