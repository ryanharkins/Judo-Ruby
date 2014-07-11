require 'spec_helper'
require_relative '../../../lib/judopay/models/web_payments/transaction'

describe Judopay::WebPayments::Transaction do
  it 'should give details of a single web transaction given a valid reference' do
    reference = '4gcBAAMAGAASAAAADA66kRor6ofknGqU3A6i-759FprFGPH3ecVcW5ChMQK0f3pLBQ'
    stub_get('/webpayments/' + reference).
      to_return(:status => 200,
                :body => lambda { |_request| fixture('web_payments/payments/find.json') })

    payment = Judopay::WebPayments::Transaction.find(reference)
    expect(payment).to be_a(Hash)
    expect(payment.reference).to eq(reference)
  end
end
