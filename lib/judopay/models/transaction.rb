require_relative '../model'
require_relative '../../patches/hash'

module Judopay
  class Transaction < Model
    @@resource_path = 'transactions/'

    def self.all(options = {})
      api = Judopay::API.new
      valid_options = self.valid_options(options).camel_case_keys!
      uri = @@resource_path + '?' + valid_options.to_query_string
      api.get(uri)
    end

    def self.find(receipt_id)
      api = Judopay::API.new
      api.get('transactions/' + receipt_id.to_i.to_s)
    end
  end  
end