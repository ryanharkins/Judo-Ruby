require_relative '../model'
require_relative 'inner/pk_payment'

module Judopay
  class ApplePayment < Model
    @resource_path = 'transactions/payments'
    @valid_api_methods = [:create]

    attribute :your_consumer_reference, String # required
    attribute :your_payment_reference, String # required
    attribute :your_payment_meta_data, Hash
    attribute :judo_id, String # required
    attribute :amount, Float # required
    attribute :currency, String
    attribute :client_details, Hash
    attribute :pk_payment, Judopay::PkPayment

    validates_presence_of :your_consumer_reference,
                          :your_payment_reference,
                          :judo_id,
                          :amount,
                          :currency

    validate_nested_model :pk_payment
  end
end
