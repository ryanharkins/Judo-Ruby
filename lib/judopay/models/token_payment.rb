require_relative '../model'
require_relative 'payment'
require_relative 'card_address'

module Judopay
  class TokenPayment < Model
    @resource_path = 'transactions/payments'
    @valid_api_methods = [:create]

    attribute :your_consumer_reference, String
    attribute :your_payment_reference, String
    attribute :your_payment_meta_data, Hash
    attribute :judo_id, String
    attribute :amount, Float
    attribute :consumer_token, String
    attribute :card_token, String
    attribute :cv2, String
    attribute :mobile_number, String
    attribute :email_address, String
    attribute :currency, String
    attribute :client_details, Hash

    validates_presence_of :your_consumer_reference,
                          :your_payment_reference,
                          :judo_id,
                          :amount,
                          :consumer_token,
                          :card_token
  end
end
