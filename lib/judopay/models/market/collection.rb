require_relative '../../model'

module Judopay
  module Market
    class Collection < Model
      @resource_path = 'market/transactions/collections'
      @valid_api_methods = [:all]
    end
  end
end
