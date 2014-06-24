require_relative '../model'
require_relative 'token_payment'

module Judopay
  # Inherit from TokenPayment - attributes are identical
  class TokenPreauth < TokenPayment
    @resource_path = 'transactions/preauths'
    @valid_api_methods = [:create]    
  end  
end