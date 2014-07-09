require_relative '../../model'

module Judopay
  module WebPayments
    class Transaction < Model
      @resource_path = 'webpayments'
      @valid_api_methods = [:find]

      # Find a specific web payment given a valid payment reference
      #
      # @param reference [String] Payment reference
      # @return [Judopay::Mash] Mash of the API response   
      def self.find(reference)
        api = Judopay::API.new
        api.get(@resource_path + '/' + reference.to_s)
      end
    end
  end
end