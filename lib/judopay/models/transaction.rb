require_relative '../model'

module Judopay
  class Transaction < Model
    @resource_path = 'transactions'
    @valid_api_methods = [:all, :find]
  end
end
