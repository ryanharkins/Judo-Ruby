require_relative 'base/integration_base'

class AdditionsPaymentTest < IntegrationBase
  def test_one_use_token_payment
    generated_token = generate_and_validate_token
    successfully_use_one_use_token(generated_token)
    cannot_reuse_one_use_token(generated_token)
  end

  def generate_and_validate_token
    encryption = build(:encrypt_details, {}).create
    assert_not_nil(encryption)
    generated_token = encryption['oneUseToken']
    assert_not_nil(generated_token)
    generated_token
  end

  def successfully_use_one_use_token(generated_token)
    encrypted_payment = build(:one_use_token_payment, :one_use_token => generated_token).create
    assert_not_nil(encrypted_payment)
    assert_equal('Success', encrypted_payment['result'])
  end

  def cannot_reuse_one_use_token(generated_token)
    second_encrypted_payment = build(:one_use_token_payment, :one_use_token => generated_token)
    assert_raise(Judopay::APIError.new('The one time token is not valid. It could have expired. Please try again')) do
      second_encrypted_payment.create
    end
  end
end
