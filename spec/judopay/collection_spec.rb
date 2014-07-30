require 'spec_helper'
require_relative '../../lib/judopay/models/collection'

describe Judopay::Collection do
  it 'should list all transactions' do
    stub_get('/transactions/collections').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/all.json') })

    transactions = Judopay::Collection.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to eq(1.01)
  end

  it 'should create a new collection given a valid payment reference' do
    stub_post('/transactions/collections').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('card_payments/create.json') })

    collection = build(:collection)
    response = collection.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
  end
end
