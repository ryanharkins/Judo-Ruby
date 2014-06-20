require 'virtus'
require 'active_model'

module Judopay
  class CardAddress
    include Virtus.model
    include ActiveModel::Validations

    attribute :line1, String
    attribute :line2, String
    attribute :line3, String
    attribute :town, String
    attribute :postcode, String
  end
end