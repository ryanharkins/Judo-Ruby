require_relative '../model'

module Judopay
  class Payment < Model
    def self.all
      api = Judopay::API.new
      api.get('transactions/payments')
    end
  end  
end