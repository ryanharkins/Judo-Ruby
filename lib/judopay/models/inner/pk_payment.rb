require_relative '../../model'
require_relative 'pk_payment_token'
require 'judopay/mash'
require 'json'

module Judopay
  class PkPayment < Model
    WRONG_OBJECT_ERROR_MESSAGE = 'You passed wrong value to the PkPayment. Please pass Hash or json-encoded string'.freeze
    WRONG_JSON_ERROR_MESSAGE = 'Can\'t decode pkPayment object from JSON'.freeze

    attribute :token, Judopay::PkPaymentToken
    attribute :billing_address, String
    attribute :shipping_address, String

    validate_nested_model :token

    def self.new(*args)
      super(validate_data(*args))
    end

    def ==(other)
      to_yaml == other.to_yaml
    end

    def self.validate_data(data)
      if data.is_a?(String)
        begin
          data = JSON.parse(data)
        rescue
          raise Judopay::ValidationError, WRONG_JSON_ERROR_MESSAGE
        end
      end
      raise Judopay::ValidationError, WRONG_OBJECT_ERROR_MESSAGE unless data.is_a?(Hash) || data.is_a?(Judopay::Mash)
      data = Judopay::Mash.new(data)
      data = data['pk_payment'] if data.key?('pk_payment')

      data
    end
  end
end
