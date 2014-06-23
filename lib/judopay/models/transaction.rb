require_relative '../model'
require_relative '../../patches/hash'

module Judopay
  class Transaction < Model
    def self.all(options = {})
      api = Judopay::API.new
      uri = 'transactions?' + self.valid_options(options).to_query_string
      api.get(uri)
    end

    def self.find(receipt_id)
      api = Judopay::API.new
      api.get('transactions/' + receipt_id.to_i.to_s)
    end
  end  
end