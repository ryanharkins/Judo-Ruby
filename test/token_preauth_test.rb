require 'base/token_payment_tests'
require 'base/integration_base'

class TokenPaymentTest < IntegrationBase
  include TokenPaymentTests

  def get_model(params = {})
    build(:token_preauth, { :consumer_token => @consumer_token, :card_token => @card_token }.merge(params))
  end
end
