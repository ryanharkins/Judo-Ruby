require 'spec_helper'
require_relative '../../lib/judopay/models/transaction'

describe Judopay::Transaction do
  it "should list all transactions" do
    stub_get('/transactions').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/all.json") })

    transactions = Judopay::Transaction.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to equal(1.01)
  end

  it "should give details of a single transaction given a valid receipt ID" do
    stub_get('/transactions/439539').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/find.json") })

    receipt_id = '439539'
    transaction = Judopay::Transaction.find(receipt_id)
    expect(transaction).to be_a(Hash)
    expect(transaction.receipt_id).to eq(receipt_id)                   
  end

  it "should send paging parameters with a request" do
    stub_get('/transactions').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/all.json") })

    options = {
      :sort => 'time-descending',
      :offset => 10,
      :page_size => 5,
      :dodgy_param => 'banana'
    }

    expected_request_options = {
      :sort => 'time-descending',
      :offset => 10,
      :pageSize => 5
    }

    Judopay::Transaction.all(options)

    WebMock.should have_requested(
      :get, 
      Judopay.configuration.endpoint_url + '/transactions'
    ).with(:query => expected_request_options)
  end
end