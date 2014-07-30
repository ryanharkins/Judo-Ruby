require 'spec_helper'
require_relative '../../../lib/judopay/models/market/transaction'

describe Judopay::Market::Transaction do
  it 'should list all transactions' do
    stub_get('/market/transactions').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/all.json') })

    transactions = Judopay::Market::Transaction.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to eq(1.01)
  end
end
