require File.expand_path('connection', __dir__)
require File.expand_path('request', __dir__)

module Judopay
  # @private
  class API
    include Connection
    include Request
  end
end
