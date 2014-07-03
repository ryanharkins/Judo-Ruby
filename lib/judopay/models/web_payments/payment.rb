require_relative '../../model'

module Judopay
  module WebPayments
    class Payment < Model
      @resource_path = 'webpayments/payments'
      @valid_api_methods = [:find]

      # Web payments uses a different endpoint for finding transactions (/webpayments)
      # Reference is a string (standard payments use an integer)
      def self.find(reference)
        api = Judopay::API.new
        api.get('webpayments/' + reference.to_s)
      end
    end
  end
end
