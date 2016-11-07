require 'json'

module Judopay
  # Single field error model
  class FieldError
    attr_accessor :message, :code, :field_name, :detail

    def initialize(message, code, field_name, detail)
      @detail = detail
      @field_name = field_name
      @code = code
      @message = message
    end

    def to_s
      "Field \"#{@field_name}\" (code #{@code}): #{@message}"
    end
  end

  # Custom error class for rescuing from all API errors
  class APIError < StandardError
    CATEGORY_UNKNOWN = 0
    CATEGORY_REQUEST = 1
    CATEGORY_MODEL = 2
    CATEGORY_CONFIG = 3
    CATEGORY_PROCESSING = 4
    CATEGORY_EXCEPTION = 5

    attr_accessor :message, :error_code, :status_code, :category, :field_errors

    class << self
      def factory(response)
        parsed_body = JSON.parse(response.body)

        new(
          parsed_body['message'],
          parsed_body['code'],
          response.status.to_i,
          parsed_body['category'],
          extract_field_errors(parsed_body['details'])
        )
      end

      protected

      def extract_field_errors(field_errors)
        result = []

        if field_errors.is_a?(Hash) && field_errors.key?('receiptId')
          result << 'Duplicate transaction. Receipt id: ' + field_errors['receiptId'].to_s
        else
          field_errors.to_a.each do |field_error|
            result << FieldError.new(field_error['message'], field_error['code'], field_error['fieldName'], field_error['detail'])
          end
        end

        result
      end
    end

    def initialize(message, error_code = 0, status_code = 0, category = CATEGORY_UNKNOWN, field_errors = [])
      @message = message
      @error_code = error_code
      @status_code = status_code
      @category = category
      @field_errors = field_errors
    end

    def to_s
      "JudoPay ApiException (status code #{@status_code}, error code #{@error_code}, category #{@category}) #{message}"
    end

    def message
      (@message || self.class.name) + field_errors_message
    end

    protected

    def field_errors_message
      return '' if @field_errors.empty?
      "\nFields errors:\n#{@field_errors.join("\n")}"
    end
  end

  # A validation error that hasn't reached the API
  class ValidationError < StandardError
    attr_accessor :errors, :message

    def initialize(message, errors = nil)
      @errors = errors
      @message = message
      @message += model_errors_summary unless @errors.nil?
    end

    def to_s
      @message
    end

    def model_errors
      return if @errors.nil?
      @errors.messages
    end

    protected

    def model_errors_summary
      summary = ["\nField errors:"]
      model_errors.each do |key, value|
        summary.push("#{key}: #{value.join('; ')}")
      end

      summary.join("\n")
    end
  end
end
