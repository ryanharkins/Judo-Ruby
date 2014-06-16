require 'spec_helper'

describe Judopay do
	it "should pass" do
    payment = FactoryGirl.build(:payment)
    puts payment.inspect
		expect(true).to eq(true)
	end
end