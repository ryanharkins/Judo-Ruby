module Judopay
  class Transaction
    def self.all
      api = Judopay::API.new
      api.get('transactions')
    end
  end
end