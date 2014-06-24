require 'faraday_middleware/response/rashify'
require_relative '../judopay/mash'

module FaradayMiddleware
  # Public: Converts parsed response bodies to a Hashie::Rash if they were of
  # Hash or Array type.
  class JudoMashify < Rashify
    dependency do
      require 'rash'
      self.mash_class = ::Judopay::Mash
    end
  end
end