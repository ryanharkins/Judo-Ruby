require_relative '../model'

module Judopay
  class Payment < Model
    @resource_path = 'transactions/payments'
    @valid_api_methods = [:all]
  end  
end