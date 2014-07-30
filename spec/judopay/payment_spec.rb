require 'spec_helper'
require_relative '../../lib/judopay/models/payment'

describe Judopay::Payment do
  it 'should list all payments' do
    stub_get('/transactions').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/all.json') })

    transactions = Judopay::Payment.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to eq(1.01)
  end
end
