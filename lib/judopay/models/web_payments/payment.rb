require_relative '../../model'

module Judopay
  module WebPayments
    class Payment < Model
      @resource_path = 'webpayments/payments'
      @valid_api_methods = [:find, :create]

    attribute :judo_id, String
    attribute :amount, Float
    attribute :partner_service_fee, Float
    attribute :your_consumer_reference, String
    attribute :your_payment_reference, String
    attribute :your_payment_meta_data, Hash
    attribute :client_ip_address, String
    attribute :client_user_agent, String

    validates_presence_of :judo_id,
                          :your_consumer_reference,
                          :your_payment_reference,
                          :amount

      # Web payments uses a different endpoint for finding transactions (/webpayments)
      # Reference is a string (standard payments use an integer)
      def self.find(reference)
        api = Judopay::API.new
        api.get('webpayments/' + reference.to_s)
      end
    end
  end
end
