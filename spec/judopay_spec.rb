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
                :body => lambda { |request| JSON.generate({'results' => [{'amount' => 1.01}]}) })

    Judopay.configure

    transactions = Judopay::Transaction.all
    expect(transactions).to be_a(Hash)
    expect(transactions.results[0].amount).to equal(1.01)
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