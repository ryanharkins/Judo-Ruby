require 'hashie'

module Judopay
  class Mash < ::Hashie::Mash

    protected

    def convert_key(key)
      camelcase_to_underscore(key.to_s)
    end

    def camelcase_to_underscore(string)
      string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end
  end
end
