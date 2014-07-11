require 'spec_helper'
require_relative '../../../lib/judopay/models/web_payments/preauth'

describe Judopay::WebPayments::Preauth do
  it 'should create a new web preauth request' do
    stub_post('/webpayments/payments').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('web_payments/payments/create.json') })

    payment = build(:web_preauth)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.post_url).to eq('https://pay.judopay-sandbox.com/')
  end
end
