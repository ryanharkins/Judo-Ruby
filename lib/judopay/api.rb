require File.expand_path('../connection', __FILE__)
require File.expand_path('../request', __FILE__)

module Judopay
  # @private
  class API
    include Connection
    include Request
    #include OAuth
  end
end
