require 'spec_helper'
require_relative '../../lib/judopay/models/refund'

describe Judopay::Refund do
  it 'should list all refunds' do
    stub_get('/transactions/refunds').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/all.json') })

    transactions = Judopay::Refund.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to eq(1.01)
  end

  it 'should create a new refund given a valid payment reference' do
    stub_post('/transactions/refunds').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('card_payments/create.json') })

    refund = build(:refund)
    response = refund.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
  end
end
