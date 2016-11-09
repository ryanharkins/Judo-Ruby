require_relative '../../model'
require 'judopay/mash'
require 'json'

module Judopay
  class TransmittedField < Model
    WRONG_OBJECT_ERROR_MESSAGE = 'You passed wrong value to the %s. Please pass Hash or json-encoded string'.freeze
    WRONG_JSON_ERROR_MESSAGE = 'Can\'t decode %s object from JSON'.freeze

    class << self
      attr_accessor :field_name

      def new(*args)
        super(validate_data(*args))
      end

      protected

      def validate_data(data)
        data = parse_string(data) if data.is_a?(String)
        raise Judopay::ValidationError, format(WRONG_OBJECT_ERROR_MESSAGE, name) unless data.is_a?(Hash) || data.is_a?(Judopay::Mash)
        data = Judopay::Mash.new(data)
        data = data[field_name] if data.key?(field_name)

        data
      end

      def parse_string(string)
        JSON.parse(string)
      rescue
        raise Judopay::ValidationError, format(WRONG_JSON_ERROR_MESSAGE, name)
      end
    end

    def ==(other)
      to_yaml == other.to_yaml
    end
  end
end
