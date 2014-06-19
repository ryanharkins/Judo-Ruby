require 'spec_helper'

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

  it "should save a new transaction given valid card details" do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/save.json") })

    transaction = Judopay::Transaction.new(
      :your_consumer_reference => '123',
      :your_payment_reference => '456',
      :judo_id => '123-456',
      :amount => 1.01,
      :card_number => '4976000000003436',
      :expiry_date => '12/15',
      :cv2 => '452'
    )
    
    response = transaction.save

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Success")
  end
end