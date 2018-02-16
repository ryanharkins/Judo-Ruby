require_relative 'base/payments_tests'
require_relative 'base/integration_base'

class PaymentTest < IntegrationBase
  include PaymentTests

  def get_model(params = {})
    build(:card_payment, params)
  end
end
