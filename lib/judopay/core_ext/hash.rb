require 'addressable/uri'
require_relative 'string'

class Hash
  # Convert hash keys to camelcase
  #
  #  {'this_key' => 1}.camel_case_keys! #=> { 'thisKey' => 1 }
  def camel_case_keys!
    output_hash = {}
    each do |key, value|
      camel_case_key = key.to_s.camel_case
      if value.is_a?(Hash)
        output_hash[camel_case_key] = value.camel_case_keys!
      else
        output_hash[key.to_s.camel_case] = value
      end
    end
    replace(output_hash)
  end

  # Produce a URL query string from the hash
  #
  #  {'this_key' => 1}.to_query_string #=> this_key=1
  def to_query_string
    uri = Addressable::URI.new
    uri.query_values = self
    uri.query
  end
end
