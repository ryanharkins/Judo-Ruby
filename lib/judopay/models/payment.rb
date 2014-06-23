require_relative '../model'

module Judopay
  class Payment < Model

    self.resource_path = 'transactions/payments'
        
    def create
      self.check_validation
      api = Judopay::API.new
      self.judo_id = Judopay.configuration.judo_id if self.judo_id.nil?
      api.post('transactions/payments', self)
    end
  end  
end