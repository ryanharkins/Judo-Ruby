require_relative '../model'

module Judopay
  class Collection < Model
    @resource_path = 'transactions/collections'
    @valid_api_methods = [:all, :create]

    attribute :receipt_id, Integer
    attribute :amount, Float
    attribute :your_payment_reference, String

    validates_presence_of :receipt_id,
                          :amount,
                          :your_payment_reference
  end
end
