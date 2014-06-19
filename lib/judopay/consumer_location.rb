require 'virtus'
require 'active_model'

module Judopay
  class ConsumerLocation
    include Virtus.model
    include ActiveModel::Validations

    attribute :latitude, Float
    attribute :longitude, Float
  end
end