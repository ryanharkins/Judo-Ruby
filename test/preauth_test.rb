require 'base/payments_tests'
require 'base/integration_base'

class PreauthTest < IntegrationBase
  include PaymentTests

  def get_model(params = {})
    build(:card_preauth, params)
  end
end
