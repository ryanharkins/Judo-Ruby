require_relative '../../model'

module Judopay
  module Market
    class Refund < Model
      @resource_path = 'market/transactions/refunds'
      @valid_api_methods = [:all]
    end
  end
end
