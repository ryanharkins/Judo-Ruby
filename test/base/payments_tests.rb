require_relative '../base/integration_base'
require_relative '../helper/assertion_helper'

module PaymentTests
  def test_valid_payment
    result = get_model.create

    TestHelpers::AssertionHelper.assert_successful_payment(result)
  end

  def test_declined_payment
    result = get_model(:declined).create

    TestHelpers::AssertionHelper.assert_declined_payment(result)
  end

  def test_payment_with_negative_amount
    TestHelpers::AssertionHelper.api_exception_with_errors(1, 1) { get_model(:amount => -1.0).create }
  end

  def test_payment_with_zero_amount
    TestHelpers::AssertionHelper.api_exception_with_errors(1, 1) { get_model(:amount => 0).create }
  end

  def test_payment_without_currency
    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\ncurrency: can't be blank")) do
      get_model(:currency => nil).create
    end
  end

  def test_payment_with_unknown_currency
    TestHelpers::AssertionHelper.api_exception_with_errors(2, 1) { get_model(:currency => 'ZZZ').create }
  end

  def test_payment_without_reference
    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\nyour_consumer_reference: can't be blank")) do
      get_model(:your_consumer_reference => nil).create
    end
  end

  def test_duplicate_payment
    model = get_model
    TestHelpers::AssertionHelper.assert_successful_payment(model.create)

    TestHelpers::AssertionHelper.api_exception_with_errors(1, 86, 409, 4) { model.create }
  end
end
