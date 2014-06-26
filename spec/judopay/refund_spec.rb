require 'spec_helper'
require_relative '../../lib/judopay/models/refund'

describe Judopay::Refund do
  it "should list all refunds" do
    stub_get('/transactions/refunds').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/all.json") })

    transactions = Judopay::Refund.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to equal(1.01)
  end

  it "should create a new refund given a valid payment reference" do
    stub_post('/transactions/refunds').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/create.json") })

    payment = Judopay::Refund.new(
      :receipt_id => '1234',
      :amount => 1.01,
      :your_payment_reference => 'payment12412312'
    )
    
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Success")
  end    
end