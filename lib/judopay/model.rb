require 'virtus'
require 'active_model'
require_relative '../patches/hash'

module Judopay
  class Model
    include Virtus.model
    include ActiveModel::Validations

    protected
    # Has the pre-validation found any problems?
    # We check the basic fields have been completed to avoid the round trip to the API
    def check_validation
      unless valid?
        raise Judopay::BadRequest, 'Validation failed: ' + self.errors.full_messages.join('; ')
      end
    end    
  end
end