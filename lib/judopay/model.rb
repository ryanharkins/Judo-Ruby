require 'addressable/uri'
require 'virtus'
require 'active_model'
require_relative 'core_ext/hash'
require_relative 'error'

module Judopay
  # Base model for Judopay API model objects
  class Model
    send :include, Virtus.model
    include ActiveModel::Validations
    VALID_PAGING_OPTIONS = [:sort, :offset, :page_size]

    class << self
      @resource_path = nil
      @valid_api_methods = []
      attr_accessor :resource_path, :valid_api_methods
    end

    # List all records
    #
    # @param options [Hash] Paging options (sort, offset and page_size)
    # @return [Judopay::Mash] Mash of the API response
    def self.all(options = {})
      check_api_method_is_supported(__method__)
      api = Judopay::API.new
      valid_options = self.valid_options(options).camel_case_keys!
      uri = resource_path + '?' + valid_options.to_query_string
      api.get(uri)
    end

    # Retrieve a specific record
    #
    # @param receipt_id [Integer] Paging options (sort, offset and page_size)
    # @return [Judopay::Mash] Mash of the API response
    def self.find(receipt_id)
      check_api_method_is_supported(__method__)
      api = Judopay::API.new
      api.get(resource_path + receipt_id.to_i.to_s)
    end

    # Create a new record
    #
    # @return [Judopay::Mash] Mash of the API response
    def create
      check_api_method_is_supported(__method__)
      check_judo_id
      check_validation
      api = Judopay::API.new
      api.post(resource_path, self)
    end

    # Retrieve the current API resource path (e.g. /transactions/payments)
    #
    # @return [String] Resource path
    def resource_path
      self.class.resource_path
    end

    # Retrieve an array of valid API methods for the current model
    # e.g [:find, :create]
    #
    # @return [Array<Symbol>] Valid API methods
    def valid_api_methods
      self.class.valid_api_methods
    end

    # Verify if an API method is supported for the current model
    def check_api_method_is_supported(method)
      self.class.check_api_method_is_supported(method)
    end

    # Use judo_id from configuration if it hasn't been explicitly set
    def check_judo_id
      if self.respond_to?('judo_id') && judo_id.nil?
        self.judo_id = Judopay.configuration.judo_id
      end
    end

    protected

    # Has the pre-validation found any problems?
    # We check the basics have been completed to avoid round trip to API
    #
    # @return nil
    # @raise [Judopay::ValidationError] if there are validation errors on the model
    def check_validation
      fail Judopay::ValidationError, errors unless valid?
    end

    # Check if the specified API method is supported by the current model
    #
    # @raise [Judopay::Error] if the API method is not supported
    def self.check_api_method_is_supported(method)
      if valid_api_methods.nil? || !valid_api_methods.include?(method.to_sym)
        fail Judopay::Error, 'API method not supported'
      end
    end

    # Take an paging options hash and filter all but the valid keys
    def self.valid_options(options)
      valid_options = {}
      options.each do |key, value|
        next unless VALID_PAGING_OPTIONS.include?(key)
        valid_options[key] = value
      end
      valid_options
    end
  end
end
