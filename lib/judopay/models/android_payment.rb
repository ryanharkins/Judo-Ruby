require_relative '../model'
require_relative 'inner/wallet'

module Judopay
  class AndroidPayment < Model
    @resource_path = 'transactions/payments'
    @valid_api_methods = [:create]

    attribute :your_consumer_reference, String # required
    attribute :your_payment_reference, String # required
    attribute :your_payment_meta_data, Hash
    attribute :judo_id, String # required
    attribute :amount, Float # required
    attribute :currency, String
    attribute :client_details, Hash
    attribute :wallet, Judopay::Wallet

    validates_presence_of :your_consumer_reference,
                          :your_payment_reference,
                          :judo_id,
                          :amount,
                          :currency

    validate_nested_model :wallet
  end
end
