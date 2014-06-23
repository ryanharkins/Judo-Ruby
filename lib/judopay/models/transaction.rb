require_relative '../model'

module Judopay
  class Transaction < Model
    def self.all(*options)
      api = Judopay::API.new
      api.get('transactions')
    end

    def self.find(receipt_id)
      api = Judopay::API.new
      api.get('transactions/' + receipt_id.to_i.to_s)
    end
  end  
end