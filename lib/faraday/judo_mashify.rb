require 'faraday_middleware/response/rashify'
require_relative '../judopay/mash'

# @private
module FaradayMiddleware
  # Convert parsed response bodies to a Hashie::Rash if they are a Hash or Array
  class JudoMashify < Rashify
    dependency do
      require 'rash'
      self.mash_class = ::Judopay::Mash
    end
  end
end
