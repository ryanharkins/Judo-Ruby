require_relative '../model'
require_relative '../../patches/hash'

module Judopay
  class Transaction < Model
    self.resource_path = 'transactions'
  end  
end