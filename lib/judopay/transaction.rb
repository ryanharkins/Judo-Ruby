require 'virtus'
require 'active_model'
require_relative '../patches/hash'

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

    def save
      api = Judopay::API.new
      api.post('transactions/payments', self.attributes.camel_case_keys!)
    end

    def self.all
      api = Judopay::API.new
      api.get('transactions')
    end

    def self.find(receipt_id)
      api = Judopay::API.new
      api.get('transactions/' + receipt_id.to_i.to_s)
    end
  end
end