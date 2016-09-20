require 'base/integration_base'

class AuthenticationTest < IntegrationBase
  def test_payment_with_invalid_judo_id
    payment = build(:card_payment, :judo_id => 123)

    AssertionHelper.api_exception_with_errors(1, 1) { payment.create }
  end

  def test_payment_with_invalid_token
    Judopay.configuration.api_token = 'Bad_token'
    payment = build(:card_payment)

    AssertionHelper.api_exception_with_errors(0, 403, 403, 1) { payment.create }
  end

  def test_payment_with_invalid_secret
    Judopay.configuration.api_secret = 'Bad_secret'
    payment = build(:card_payment)

    AssertionHelper.api_exception_with_errors(0, 403, 403, 1) { payment.create }
  end
end
