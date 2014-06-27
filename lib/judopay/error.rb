require 'json'

module Judopay
  # Custom error class for rescuing from all API errors
  class Error < StandardError
    attr_accessor :response, :error_type, :model_errors, :message

    def initialize(response = nil)
      @response = response

      # If we got a JSON response body, set variables
      return if parsed_body.nil?
      
      @message = body_attribute('errorMessage')
      @error_type = body_attribute('errorType').to_i
      @model_errors = body_attribute('modelErrors')
    end

    def http_status
      @response.status.to_i if @response
    end

    def http_body
      @response.body if @response
    end

    def to_s
      @message
    end

    def message
      @message || self.class.name
    end

    # @todo Memoize the result of parsed_body
    def parsed_body
      return unless @response.respond_to?('response_headers')
      unless @response.response_headers.include?('Content-Type') && @response.response_headers['Content-Type'] == 'application/json'
        return nil
      end

      ::JSON.parse(@response.body)
    end

    protected

    def body_attribute(attribute)
      return nil if parsed_body.nil? || !parsed_body.include?(attribute)
      parsed_body[attribute]
    end
  end

  # Raised when API returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when API returns the HTTP status code 401
  class NotAuthorized < Error; end

  # Raised when API returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when API returns the HTTP status code 409
  class Conflict < Error; end

  # Raised when API returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when API returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when API returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when API returns the HTTP status code 504
  class GatewayTimeout < Error; end
end
