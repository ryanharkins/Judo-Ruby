require 'base/payments_tests'
require 'base/integration_base'

class RegisterCardTest < IntegrationBase
  include PaymentTests

  def get_model(params = {})
    build(:register_card, params)
  end

  def test_payment_with_unknown_currency
    TestHelpers::AssertionHelper.api_exception_with_errors(0, 72, 409, 3) { get_model(:currency => 'ZZZ').create }
  end

  def test_payment_changed_amount
    result = get_model(:amount => 100_500).create

    TestHelpers::AssertionHelper.assert_successful_payment(result)
    assert_equal('1.01', result['amount'])
  end

  def test_payment_without_currency
    result = get_model(:currency => nil).create

    TestHelpers::AssertionHelper.assert_successful_payment(result)
  end

  def test_payment_with_negative_amount
    # Unneeded test
    assert_true(true)
  end

  def test_payment_with_zero_amount
    # Unneeded test
    assert_true(true)
  end

  def test_duplicate_payment
    # Unneeded test
    assert_true(true)
  end
end
