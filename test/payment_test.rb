require 'base/payments_tests'
require 'base/integration_base'

class PaymentTest < IntegrationBase
  include PaymentTests

  def get_model(params = {})
    build(:card_payment, params)
  end
end
