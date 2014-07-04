require 'spec_helper'
require_relative '../../../lib/judopay/models/web_payments/preauth'

describe Judopay::WebPayments::Preauth do
  it "should give details of a single web preauth given a valid reference" do
    reference = '4gcBAAMAGAASAAAADA66kRor6ofknGqU3A6i-759FprFGPH3ecVcW5ChMQK0f3pLBQ'
    stub_get('/webpayments/' + reference).
      to_return(:status => 200,
                :body => lambda { |request| fixture("web_payments/payments/find.json") })

    payment = Judopay::WebPayments::Preauth.find(reference)
    expect(payment).to be_a(Hash)
    expect(payment.reference).to eq(reference)                   
  end

  it "should create a new web preauth request" do
    stub_post('/webpayments/payments').
      to_return(:status => 200,
                :body => lambda { |request| fixture("web_payments/payments/create.json") })

    payment = build(:web_preauth)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.post_url).to eq("https://pay.judopay-sandbox.com/")
  end  
end