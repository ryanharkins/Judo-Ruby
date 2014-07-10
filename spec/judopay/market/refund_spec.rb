require 'spec_helper'
require_relative '../../../lib/judopay/models/market/refund'

describe Judopay::Market::Refund do
  it "should list all transactions" do
    stub_get('/market/transactions/refunds').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/all.json") })

    transactions = Judopay::Market::Refund.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to equal(1.01)
  end

  it "should create a new refund given a valid payment reference" do
    stub_post('/market/transactions/refunds').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/create.json") })

    refund = build(:market_refund)
    response = refund.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Success")
  end  
end