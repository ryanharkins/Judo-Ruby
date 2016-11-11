require_relative '../model'
require_relative 'payment'
require_relative 'card_address'

module Judopay
  # Inherit from CardPayment - attributes are identical
  class CardPreauth < CardPayment
    @resource_path = 'transactions/preauths'
    @valid_api_methods = [:create, :validate]
  end
end
