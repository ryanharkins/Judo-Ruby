require_relative '../../model'

module Judopay
  module WebPayments
    class Payment < Model
      @resource_path = 'webpayments/payments'
      @valid_api_methods = [:find]
    end
  end
end
