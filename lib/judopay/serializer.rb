module Judopay
  # @private
  class Serializer
    attr_reader :serialized_object

    def initialize(serialized_object)
      @serialized_object = serialized_object
    end

    def as_json
      output_hash = hashify(@serialized_object).camel_case_keys!
      JSON.generate(output_hash)
    end

    # Turn a hash with nested Virtus objects into a simple nested hash
    def hashify(source)
      output_hash = {}
      source.to_hash.each do |key, value|
        next if value.nil?

        # Is this a Virtus model object that we need to hashify?
        output_hash[key] = value.class.included_modules.include?(Virtus::Model::Core) ? hashify(value) : value
      end
      output_hash
    end
  end
end
