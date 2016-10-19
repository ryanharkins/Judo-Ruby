require_relative '../judopay/mash'

# @private
module FaradayMiddleware
  # Convert parsed response bodies to a Hashie::Mash if they are a Hash or Array
  class JudoMashify < Mashify
    dependency do
      self.mash_class = ::Judopay::Mash
    end
  end
end
