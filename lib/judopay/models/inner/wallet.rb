require_relative 'transmitted_field'

module Judopay
  class Wallet < TransmittedField
    attribute :encrypted_message, String
    attribute :environment, Integer
    attribute :ephemeral_public_key, String
    attribute :google_transaction_id, String
    attribute :instrument_details, String
    attribute :instrument_type, String
    attribute :public_key, String
    attribute :tag, String
    attribute :version, Integer

    validates_presence_of :encrypted_message,
                          :environment,
                          :ephemeral_public_key,
                          :google_transaction_id,
                          :instrument_details,
                          :instrument_type,
                          :public_key,
                          :tag,
                          :version

    def self.new(*args)
      self.field_name = 'wallet'
      super(*args)
    end
  end
end
