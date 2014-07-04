require_relative '../../model'

module Judopay
  module WebPayments
    class Preauth < Payment
      @resource_path = 'webpayments/preauths'
      @valid_api_methods = [:find, :create]      
    end
  end
end
