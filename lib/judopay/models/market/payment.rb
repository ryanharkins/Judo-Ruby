require_relative '../../model'

module Judopay
  module Market
    class Payment < Model
      @resource_path = 'market/transactions/payments'
      @valid_api_methods = [:all]
    end
  end
end
