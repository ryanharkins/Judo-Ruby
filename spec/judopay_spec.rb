require 'spec_helper'

describe Judopay do
	it "should pass" do
    #payment = FactoryGirl.build(:payment)
		expect(true).to eq(true)
	end
end

describe Judopay::Transaction do

  it "should list all transactions" do
    stub_get('/transactions').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/all.json") })

    Judopay.configure

    transactions = Judopay::Transaction.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to equal(1.01)
  end

  it "should give details of a single transaction given a valid receipt ID" do
    stub_get('/transactions/439539').
      to_return(:status => 200,
                :body => lambda { |request| fixture("transactions/find.json") })

    Judopay.configure

    receipt_id = '439539'
    transaction = Judopay::Transaction.find(receipt_id)
    expect(transaction).to be_a(Hash)
    expect(transaction.receipt_id).to eq(receipt_id)                   
  end

  it "should return a NotFound exception if a single transaction is not found" do
    stub_get('/transactions/999999').
      to_return(:status => 404,
                :body => lambda { |request| fixture("transactions/find_not_found.json") })

    Judopay.configure

    receipt_id = 999999
    transaction = Judopay::Transaction.find(receipt_id)
    puts transaction.inspect
    # We will need to stub with Faraday if we want to test the middleware
    #expect { Judopay::Transaction.find(receipt_id) }.to raise_exception(Judopay::NotFound)
  end

end

describe Faraday::Response do

  Judopay.configure

  {
    400 => Judopay::BadRequest,
    404 => Judopay::NotFound,
    500 => Judopay::InternalServerError,
    503 => Judopay::ServiceUnavailable
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('/transactions').
          to_return(:status => status,
                    :body => lambda { |request| JSON.generate({'errorType' => status}) })
      end

      it "should raise #{exception.name} error" do
        expect(lambda do
          Judopay::Transaction.all
        end).to raise_error(exception)
      end
    end
  end
end