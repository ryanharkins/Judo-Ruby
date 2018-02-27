require_relative 'base/integration_base'

class AdditionsPaymentTest < IntegrationBase

  def test_encryption_of_card_details
    encryption = build(:encrypt_details, {}).create

    assert_not_nil(encryption)
    assert_not_nil(encryption['oneUseToken'])
  end

end
