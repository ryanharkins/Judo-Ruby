require 'json'

module Judopay
  # Custom error class for rescuing from all API errors
  class Error < StandardError
    attr_accessor :response, :error_type, :model_errors, :message, :parsed_body

    def initialize(response = nil)
      @response = response

      # Log the error
      Judopay.log(Logger::ERROR, self.class.name + ' ' + @message.to_s)

      # If we got a JSON response body, set variables
      return if parsed_body.nil?

      @message = body_attribute('errorMessage')
      @error_type = body_attribute('errorType').to_i
      api_model_errors = body_attribute('modelErrors')
      return if api_model_errors.nil?

      process_api_model_errors(api_model_errors)
    end

    def http_status
      @response.status.to_i if @response
    end

    def http_body
      @response.body if @response
    end

    def to_s
      return @message if model_errors.nil?
      
      summary = []
      model_errors.each do |key, value|
        summary.push(value.join('; '))
      end

      @message + ' (' + summary.join('; ') + ')'
    end

    def message
      @message || self.class.name
    end

    def parsed_body 
      @parsed_body ||= parse_body
    end

    protected

    def parse_body
      return unless @response.respond_to?('response_headers')
      return unless @response.response_headers.include?('Content-Type')
      return unless @response.response_headers['Content-Type'].include?('application/json')

      ::JSON.parse(@response.body)
    end

    def body_attribute(attribute)
      return nil if parsed_body.nil? || !parsed_body.include?(attribute)
      parsed_body[attribute]
    end

    # Turn API model errors into a more ActiveRecord-like format
    def process_api_model_errors(api_model_errors)
      @model_errors = {}
      api_model_errors.each do |api_model_error|
        next unless api_model_error.is_a?(Hash)
        field_name = api_model_error['fieldName'].underscore.to_sym
        if @model_errors[field_name].nil?
          @model_errors[field_name] = []
        end
        @model_errors[field_name].push(api_model_error['errorMessage'])
      end
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

  # A validation error that hasn't reached the API
  class ValidationError < StandardError
    attr_accessor :errors, :message

    def initialize(errors)
      @errors = errors
      @message = 'Missing required fields'
    end

    def to_s
      @message + ' (' + @errors.full_messages.join('; ') + ')'
    end

    def model_errors
      return if @errors.nil?
      @errors.messages
    end
  end
end
