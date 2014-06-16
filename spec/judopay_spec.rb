require 'spec_helper'

describe Judopay do
	it "should pass" do
    #payment = FactoryGirl.build(:payment)
		expect(true).to eq(true)
	end
end

describe Judopay::Transaction do

  it "should list all transactions" do
    Judopay.configure do |config|
      config.api_token = ENV['JUDO_TOKEN']
      config.api_secret = ENV['JUDO_SECRET']
    end

    expect(Judopay::Transaction.all).to be_a(Hash)
  end
end

describe Judopay::Response do
  {
    400 => Judopay::BadRequest,
    404 => Judopay::NotFound,
    500 => Judopay::InternalServerError,
    503 => Judopay::ServiceUnavailable
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      # before do
      #   stub_get('users/self/feed.json').
      #     to_return(:status => status)
      # end

      # it "should raise #{exception.name} error" do
      #   lambda do
      #     @client.user_media_feed()
      #   end.should raise_error(exception)
      # end
    end
  end
end