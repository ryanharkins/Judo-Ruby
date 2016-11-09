require_relative '../model'
require_relative 'apple_payment'

module Judopay
  class ApplePreauth < ApplePayment
    @resource_path = 'transactions/preauths'
    @valid_api_methods = [:create]
  end
end
