require_relative '../model'
require_relative 'payment'
require_relative 'card_address'

module Judopay
  class RegisterCard < Model
    @resource_path = 'transactions/registercard'
    @valid_api_methods = [:create]

    attribute :your_consumer_reference, String
    attribute :your_payment_reference, String
    attribute :card_number, String
    attribute :expiry_date, String
    attribute :cv2, String
    attribute :card_address, Judopay::CardAddress
    attribute :amount, Float
    attribute :currency, String
    attribute :judo_id, String
    attribute :your_payment_meta_data, Hash

    validates_presence_of :your_consumer_reference,
                          :your_payment_reference,
                          :card_number,
                          :expiry_date,
                          :cv2
  end
end
