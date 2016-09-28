require_relative '../model'

module Judopay
  class Void < Model
    @resource_path = 'transactions/voids'
    @valid_api_methods = [:create, :validate]

    attribute :judo_id, String
    attribute :receipt_id, Integer
    attribute :amount, Float
    attribute :your_payment_reference, String
    attribute :your_payment_meta_data, Hash
    attribute :currency, String

    validates_presence_of :receipt_id,
                          :amount,
                          :judo_id
  end
end
