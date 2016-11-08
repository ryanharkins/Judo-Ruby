require 'base/integration_base'

class VoidTest < IntegrationBase
  def test_valid_preauth_void
    receipt = make_payment
    void = build(:void, :receipt_id => receipt).create

    TestHelpers::AssertionHelper.assert_successful_payment(void)
  end

  def test_declined_payment_void
    receipt = make_payment(false)
    TestHelpers::AssertionHelper.api_exception_with_errors(0, 50, 404) { build(:void, :receipt_id => receipt).create }
  end

  def test_wrong_receipt_id
    TestHelpers::AssertionHelper.api_exception_with_errors(1, 1) { build(:void).create }
  end

  def test_double_void
    receipt = make_payment
    void = build(:void, :receipt_id => receipt)

    response = void.create

    TestHelpers::AssertionHelper.assert_successful_payment(response)
    void.your_payment_reference = SecureRandom.hex(18) + Time.now.to_i.to_s
    TestHelpers::AssertionHelper.api_exception_with_errors(0, 51) { void.create }
  end

  def test_void_with_invalid_amount
    TestHelpers::AssertionHelper.api_exception_with_errors(0, 53, 404) do
      build(:void, :receipt_id => make_payment, :amount => 100).create
    end
  end

  protected

  def make_payment(preauth = true)
    payment = build(preauth ? :card_preauth : :card_payment).create
    TestHelpers::AssertionHelper.assert_successful_payment(payment)

    payment['receiptId']
  end
end
