require_relative '../model'

module Judopay
  class Payment < Model

    def create
      self.check_validation
      api = Judopay::API.new
      self.judo_id = Judopay.configuration.judo_id if self.judo_id.nil?
      api.post('transactions/payments', self)
    end

    def self.all
      api = Judopay::API.new
      api.get('transactions/payments')
    end
  end  
end