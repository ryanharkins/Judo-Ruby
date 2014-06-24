require_relative '../model'

module Judopay
  class Collection < Model
    @resource_path = 'transactions/collections'
    @valid_api_methods = [:all]
  end  
end