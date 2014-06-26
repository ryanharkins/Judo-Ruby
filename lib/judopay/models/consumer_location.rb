require_relative '../model'

module Judopay
  class ConsumerLocation < Model
    attribute :latitude, Float
    attribute :longitude, Float
  end
end
