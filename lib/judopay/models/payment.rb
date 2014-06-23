require_relative '../model'

module Judopay
  class Payment < Model
    self.resource_path = 'transactions/payments'
  end  
end