require_relative '../model'
require_relative 'payment'
require_relative 'card_address'

module Judopay
  class SaveCard < Model
    @resource_path = 'transactions/savecard'
    @valid_api_methods = [:create]

    attribute :your_consumer_reference, String
    attribute :judo_id, String
    attribute :card_number, String
    attribute :expiry_date, String
    attribute :string_date, String
    attribute :issue_number, String
    attribute :cv2, String
    attribute :card_address, Judopay::CardAddress
    attribute :currency, String

    validates_presence_of :your_consumer_reference,
                          :card_number,
                          :expiry_date,
                          :cv2
  end
end
