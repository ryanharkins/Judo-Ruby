require_relative '../model'
require_relative 'payment'
require_relative 'card_address'

module Judopay
  class OneUseTokenPayment < Model
    @resource_path = 'transactions/preauths'
    @valid_api_methods = [:create]

    attribute :one_use_token, String # required
    attribute :your_consumer_reference, String # required
    attribute :your_payment_reference, String # required
    attribute :judo_id, String # required
    attribute :amount, Float # required
    attribute :currency, String # required
    attribute :your_payment_meta_data, Hash
    attribute :card_address, Judopay::CardAddress
    attribute :mobile_number, String
    attribute :email_address, String
    attribute :client_details, Hash

    validates_presence_of :one_use_token,
                          :your_consumer_reference,
                          :your_payment_reference,
                          :judo_id,
                          :amount,
                          :currency
  end
end
