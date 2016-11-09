require_relative 'transmitted_field'
require_relative 'pk_payment_token'

module Judopay
  class PkPayment < TransmittedField
    attribute :token, Judopay::PkPaymentToken
    attribute :billing_address, String
    attribute :shipping_address, String

    validate_nested_model :token

    def self.new(*args)
      self.field_name = 'pk_payment'
      super(*args)
    end
  end
end
