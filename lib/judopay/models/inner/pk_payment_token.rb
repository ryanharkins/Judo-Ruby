require_relative '../../model'

module Judopay
  class PkPaymentToken < Model
    attribute :payment_instrument_name, String
    attribute :payment_network, String
    attribute :payment_data, Hash

    validates_presence_of :payment_instrument_name,
                          :payment_network,
                          :payment_data
  end
end
