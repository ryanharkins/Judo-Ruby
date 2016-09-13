require 'judopay/error'
require 'test/unit/assertions'

include Test::Unit::Assertions
module TestHelpers
  class AssertionHelper
    class << self
      def api_exception_with_errors(errors_cnt_expected, error_code, status_code = 400, error_category = 2)
        exception = assert_raise(Judopay::APIError) { yield }
        puts '---------------------------'
        puts exception
        puts '---------------------------'
        assert_equal(errors_cnt_expected, exception.field_errors.count)
        assert_equal(error_code, exception.error_code)
        assert_equal(status_code, exception.status_code)
        assert_equal(error_category, exception.category)
      end
    end
  end
end
