module Judopay
  class API
    @api_version = '4.0.0'

    class << self
      attr_accessor :api_version
    end
  end
end