require 'spec_helper'
require_relative '../../../lib/judopay/models/web_payments/payment'

describe Judopay::WebPayments::Payment do
  it 'should create a new web payment request' do
    stub_post('/webpayments/payments').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('web_payments/payments/create.json') })

    payment = build(:web_payment)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.post_url).to eq('https://pay.judopay-sandbox.com/')
  end
end
