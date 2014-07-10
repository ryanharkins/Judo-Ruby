require_relative '../../model'

module Judopay
  module Market
    class Preauth < Model
      @resource_path = 'market/transactions/preauths'
      @valid_api_methods = [:all]
    end
  end
end
