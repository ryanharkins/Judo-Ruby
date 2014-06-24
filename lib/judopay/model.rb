require 'addressable/uri'
require 'virtus'
require 'active_model'
require_relative '../patches/hash'
require_relative 'error'

module Judopay
  class Model
    include Virtus.model
    include ActiveModel::Validations
    @@valid_paging_options = [:sort, :offset, :page_size]

    class << self
      @resource_path = nil
      @valid_api_methods = []
      attr_accessor :resource_path, :valid_api_methods
    end

    def self.all(options = {})
      if valid_api_methods.nil? || !valid_api_methods.include?(:all)
        raise Judopay::Error, 'API method not supported'
      end

      api = Judopay::API.new
      valid_options = self.valid_options(options).camel_case_keys!
      uri = self.resource_path + '?' + valid_options.to_query_string
      api.get(uri)
    end

    def self.find(receipt_id)
      if valid_api_methods.nil? || !valid_api_methods.include?(:find)
        raise Judopay::Error, 'API method not supported'
      end

      api = Judopay::API.new
      api.get(self.resource_path + receipt_id.to_i.to_s)
    end

    def create
      unless valid_api_methods.include?(:create)
        raise Judopay::Error, 'API method not supported'
      end

      check_validation
      api = Judopay::API.new
      self.judo_id = Judopay.configuration.judo_id if self.judo_id.nil?
      api.post(self.resource_path, self)
    end

    def resource_path
      self.class.resource_path
    end

    def valid_api_methods
      self.class.valid_api_methods
    end

    protected
    # Has the pre-validation found any problems?
    # We check the basic fields have been completed to avoid the round trip to the API
    def check_validation
      unless valid?
        raise Judopay::BadRequest, 'Validation failed: ' + self.errors.full_messages.join('; ')
      end
    end

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

  end
end