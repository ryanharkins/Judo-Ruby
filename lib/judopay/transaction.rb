require 'virtus'
require 'active_model'
require_relative '../patches/hash'
require_relative 'card_address'
require_relative 'consumer_location'

module Judopay
  class Transaction
    include Virtus.model
    include ActiveModel::Validations

    attribute :your_consumer_reference, String # required
    attribute :your_payment_reference, String # required
    attribute :your_payment_meta_data, Hash
    attribute :judo_id, String # required
    attribute :amount, Float # required
    attribute :card_number, String # required for card transactions
    attribute :expiry_date, String # required for card transactions
    attribute :cv2, String  # required for card transactions
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

    def create
      self.check_validation
      api = Judopay::API.new
      self.judo_id = Judopay.configuration.judo_id if self.judo_id.nil?
      api.post('transactions/payments', self)
    end

    def self.all
      api = Judopay::API.new
      api.get('transactions')
    end

    def self.find(receipt_id)
      api = Judopay::API.new
      api.get('transactions/' + receipt_id.to_i.to_s)
    end

    protected
    # Has the pre-validation found any problems?
    # We check the basic fields have been completed to avoid the round trip to the API
    def check_validation
      unless valid?
        raise Judopay::BadRequest, 'Validation failed: ' + self.errors.full_messages.join('; ')
      end
    end  
  end  
end
