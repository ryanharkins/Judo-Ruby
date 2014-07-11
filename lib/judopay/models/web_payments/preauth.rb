require_relative '../../model'

module Judopay
  module WebPayments
    class Preauth < Payment
      @resource_path = 'webpayments/preauths'
      @valid_api_methods = [:create]
    end
  end
end
