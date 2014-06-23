require 'addressable/uri'
require 'virtus'
require 'active_model'
require_relative '../patches/hash'

module Judopay
  class Model
    include Virtus.model
    include ActiveModel::Validations
    @@valid_paging_options = [:sort, :offset, :page_size]

    # Take an options hash and filter all but the valid keys
    def self.valid_options(options)
      valid_options = {}
      options.each do |key,value| 
        if @@valid_paging_options.include?(key)
          valid_options[key] = value
        end
      end
      valid_options
    end

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