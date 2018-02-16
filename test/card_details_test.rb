require_relative 'base/integration_base'

class CardDetailsTest < IntegrationBase
  def test_payment_with_missing_card_number
    payment = build(:card_payment, :card_number => nil)

    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\ncard_number: can't be blank")) { payment.create }
  end

  def test_payment_with_missing_cv2
    payment = build(:card_payment, :cv2 => nil)

    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\ncv2: can't be blank")) { payment.create }
  end

  def test_payment_with_missing_expiry_date
    payment = build(:card_payment, :expiry_date => nil)

    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\nexpiry_date: can't be blank")) { payment.create }
  end
end
