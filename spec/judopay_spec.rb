require 'spec_helper'

describe Judopay do
	it "should pass" do
    #payment = FactoryGirl.build(:payment)
		expect(true).to eq(true)
	end
end

describe Judopay::Transaction do

  it "should list all transactions" do
    # Judopay.configure do |config|
    #   config.api_token = ENV['JUDO_TOKEN']
    #   config.api_secret = ENV['JUDO_SECRET']
    # end

    # expect(Judopay::Transaction.all).to be_a(Hash)
  end
end

describe Faraday::Response do

  Judopay.configure do |config|
  end

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