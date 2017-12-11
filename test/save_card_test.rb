require 'base/integration_base'

class SaveCardTests < IntegrationBase
  def get_model(params = {})
    build(:save_card, params)
  end

  def test_valid_payment
    result = get_model.create
    TestHelpers::AssertionHelper.assert_successful_payment(result)
  end

  def test_payment_without_reference
    assert_raise(Judopay::ValidationError.new("Missing required fields\nField errors:\nyour_consumer_reference: can't be blank")) do
      get_model(:your_consumer_reference => nil).create
    end
  end

  def test_save_card_with_no_cv2
    result = get_model(:cv2 => '').create
    TestHelpers::AssertionHelper.assert_successful_payment(result)
  end
end
