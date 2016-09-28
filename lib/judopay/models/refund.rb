require_relative '../model'

module Judopay
  class Refund < Model
    @resource_path = 'transactions/refunds'
    @valid_api_methods = [:all, :create, :validate]

    attribute :receipt_id, Integer
    attribute :amount, Float
    attribute :your_payment_reference, String

    validates_presence_of :receipt_id,
                          :amount,
                          :your_payment_reference
  end
end
