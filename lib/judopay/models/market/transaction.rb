require_relative '../../model'

module Judopay
  module Market
    class Transaction < Model
      @resource_path = 'market/transactions'
      @valid_api_methods = [:all]
    end
  end
end
