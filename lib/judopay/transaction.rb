require 'virtus'
require 'active_model'

module Judopay
  class Transaction
    include Virtus.model
    include ActiveModel::Validations

    attribute :your_consumer_reference, String
    attribute :your_payment_reference, String

    def save
      api = Judopay::API.new
      api.post('transactions/payments', self.attributes)
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