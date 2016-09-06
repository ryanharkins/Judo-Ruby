require_relative '../model'
require_relative 'payment'
require_relative 'card_address'
require_relative 'consumer_location'

module Judopay
  class CardPayment < Model
    @resource_path = 'transactions/payments'
    @valid_api_methods = [:create, :validate]

    attribute :your_consumer_reference, String # required
    attribute :your_payment_reference, String # required
    attribute :your_payment_meta_data, Hash
    attribute :judo_id, String # required
    attribute :amount, Float # required
    attribute :card_number, String # required for card transactions
    attribute :expiry_date, String # required for card transactions
    attribute :cv2, String # required for card transactions
    attribute :card_address, Judopay::CardAddress
    attribute :consumer_location, Judopay::ConsumerLocation
    attribute :mobile_number, String
    attribute :email_address, String

    validates_presence_of :your_consumer_reference,
                          :your_payment_reference,
                          :judo_id,
                          :amount,
                          :card_number,
                          :expiry_date,
                          :cv2
  end
end
