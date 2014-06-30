require 'addressable/uri'
require 'virtus'
require 'active_model'
require_relative '../patches/hash'
require_relative 'error'

module Judopay
  # Base model for Judopay API model objects
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
      check_api_method_is_supported(__method__)
      api = Judopay::API.new
      valid_options = self.valid_options(options).camel_case_keys!
      uri = resource_path + '?' + valid_options.to_query_string
      api.get(uri)
    end

    def self.find(receipt_id)
      check_api_method_is_supported(__method__)
      api = Judopay::API.new
      api.get(resource_path + receipt_id.to_i.to_s)
    end

    def create
      check_api_method_is_supported(__method__)
      check_judo_id
      check_validation
      api = Judopay::API.new
      api.post(resource_path, self)
    end

    def resource_path
      self.class.resource_path
    end

    def valid_api_methods
      self.class.valid_api_methods
    end

    def check_api_method_is_supported(method)
      self.class.check_api_method_is_supported(method)
    end

    def check_judo_id
      # Use judo_id from config if it hasn't been explicitly set
      if self.respond_to?('judo_id') && judo_id.nil?
        self.judo_id = Judopay.configuration.judo_id
      end
    end

    protected

    # Has the pre-validation found any problems?
    # We check the basics have been completed to avoid round trip to API
    def check_validation
      unless valid?
        fail Judopay::ValidationError, errors
      end
    end

    def self.check_api_method_is_supported(method)
      if valid_api_methods.nil? || !valid_api_methods.include?(method.to_sym)
        fail Judopay::Error, 'API method not supported'
      end
    end

    # Take an options hash and filter all but the valid keys
    def self.valid_options(options)
      valid_options = {}
      options.each do |key, value|
        next unless @@valid_paging_options.include?(key)
        valid_options[key] = value
      end
      valid_options
    end
  end
end
