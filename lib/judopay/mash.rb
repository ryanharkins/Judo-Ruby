require 'hashie'

module Judopay
  class Mash < ::Hashie::Mash
    protected

    def convert_key(key)
      key.to_s.underscore
    end
  end
end
