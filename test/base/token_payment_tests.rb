require_relative '../base/integration_base'
require_relative '../helper/assertion_helper'

module TokenPaymentTests
  def setup
    super
    payment = build(:card_payment)
    result = payment.create

    TestHelpers::AssertionHelper.assert_successful_payment(result)

    @card_token = result['cardDetails']['cardToken']
    @consumer_token = result['consumer']['consumerToken']
  end

  def test_valid_token_payment
    response = get_model.create

    TestHelpers::AssertionHelper.assert_successful_payment(response)
  end

  def test_declined_token_payment
    response = get_model(:cv2 => '666').create

    TestHelpers::AssertionHelper.assert_declined_payment(response)
  end

  def test_token_payment_without_token
    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\ncard_token: can't be blank")) do
      get_model(:card_token => nil).create
    end
  end

  def test_token_payment_without_cv2_and_without_token
    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\ncard_token: can't be blank")) do
      get_model(:card_token => nil, :cv2 => nil).create
    end
  end

  def test_payment_with_negative_amount
    TestHelpers::AssertionHelper.api_exception_with_errors(1, 1) { get_model(:amount => -1.0).create }
  end

  def test_payment_with_zero_amount
    TestHelpers::AssertionHelper.api_exception_with_errors(1, 1) { get_model(:amount => 0).create }
  end

  def test_payment_without_currency
    response = get_model(:currency => nil).create
    TestHelpers::AssertionHelper.assert_successful_payment(response)
  end

  def test_payment_with_unknown_currency
    TestHelpers::AssertionHelper.api_exception_with_errors(2, 1) { get_model(:currency => 'ZZZ').create }
  end

  def test_payment_without_reference
    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\nyour_consumer_reference: can't be blank")) do
      get_model(:your_consumer_reference => nil).create
    end
  end

  def test_declined_token_payment_without_cv2
    response = get_model(:cv2 => nil).create

    TestHelpers::AssertionHelper.assert_declined_payment(response)
  end

  def test_token_payment_without_cv2_and_with_negative_amount
    TestHelpers::AssertionHelper.api_exception_with_errors(1, 1) { get_model(:amount => -1, :cv2 => nil).create }
  end

  def test_token_payment_without_cv2_and_with_zero_amount
    TestHelpers::AssertionHelper.api_exception_with_errors(1, 1) { get_model(:amount => 0, :cv2 => nil).create }
  end

  def test_token_payment_without_cv2_and_without_currency
    response = get_model(:cv2 => nil, :currency => nil).create
    TestHelpers::AssertionHelper.assert_declined_payment(response)
  end

  def test_token_payment_without_cv2_and_with_unknown_currency
    TestHelpers::AssertionHelper.api_exception_with_errors(2, 1) { get_model(:cv2 => nil, :currency => 'ZZZ').create }
  end

  def test_token_payment_without_cv2_and_without_reference
    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\nyour_consumer_reference: can't be blank")) do
      get_model(:your_consumer_reference => nil, :cv2 => nil).create
    end
  end

  def test_duplicate_payment
    model = get_model
    TestHelpers::AssertionHelper.assert_successful_payment(model.create)

    TestHelpers::AssertionHelper.api_exception_with_errors(1, 86, 409, 4) { model.create }
  end
end
