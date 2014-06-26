require_relative '../model'
require_relative 'payment'
require_relative 'card_address'
require_relative 'consumer_location'

module Judopay
  # Inherit from CardPayment - attributes are identical
  class CardPreauth < CardPayment
    @resource_path = 'transactions/preauths'
    @valid_api_methods = [:create]
  end
end
