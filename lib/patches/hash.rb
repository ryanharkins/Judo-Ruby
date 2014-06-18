require_relative 'string'

class Hash
  def camel_case_keys!
    output_hash = {}
    self.each do |key,value|
      camel_case_key = key.to_s.camel_case
      if value.is_a?(Hash)
        output_hash[camel_case_key] = value.camel_case_keys!
      else
        output_hash[key.to_s.camel_case] = value
      end
    end
    self.replace(output_hash)
  end
end