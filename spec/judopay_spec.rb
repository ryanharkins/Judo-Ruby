require 'spec_helper'

describe Judopay do
	it "should pass" do
    payment = FactoryGirl.build(:payment)
    puts payment.inspect
		expect(true).to eq(true)
	end
end

describe Judopay::Transaction do
  it "should list all transactions" do
    Judopay.configure do |config|
      config.api_token = ENV['JUDO_TOKEN']
      config.api_secret = ENV['JUDO_SECRET']
    end

    expect(Judopay::Transaction.all).to be_a(Array)
  end
end