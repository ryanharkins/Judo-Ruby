require 'judopay/error'
require 'test/unit/assertions'

module TestHelpers

  class AssertionHelper
    class << self
      include Test::Unit::Assertions
      def api_exception_with_errors(errors_cnt_expected, error_code, status_code = 400, error_category = 2)
        exception = assert_raise(Judopay::APIError) { yield }
        assert_equal(errors_cnt_expected, exception.field_errors.count)
        assert_equal(error_code, exception.error_code)
        assert_equal(status_code, exception.status_code)
        assert_equal(error_category, exception.category)
      end

      def assert_successful_payment(response)
        assert_not_nil(response)
        assert_equal('Success', response['result'])
        assert_operator(0, :<, response['receiptId'].to_i)
      end

      def assert_declined_payment(response)
        assert_not_nil(response)
        assert_equal('Declined', response['result'])
        assert_operator(0, :<, response['receiptId'].to_i)
      end
    end
  end
end
