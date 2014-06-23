require_relative '../model'

module Judopay
  class CardAddress < Model    
    attribute :line1, String
    attribute :line2, String
    attribute :line3, String
    attribute :town, String
    attribute :postcode, String
  end
end