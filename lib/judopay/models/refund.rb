require_relative '../model'

module Judopay
  class Refund < Model
    @resource_path = 'transactions/refunds'
    @valid_api_methods = [:all]
  end  
end