require_relative '../../model'

module Judopay
  module Market
    class Collection < Judopay::Collection
      @resource_path = 'market/transactions/collections'
      @valid_api_methods = [:all, :create]
    end
  end
end
