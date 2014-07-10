require 'spec_helper'
require_relative '../../../lib/judopay/models/market/preauth'

describe Judopay::Market::Preauth do
  it "should list all transactions" do
    stub_get('/market/transactions/preauths').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/all.json") })

    transactions = Judopay::Market::Preauth.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to equal(1.01)
  end
end