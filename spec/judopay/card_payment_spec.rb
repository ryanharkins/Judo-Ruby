require 'spec_helper'
require_relative '../../lib/judopay/models/card_payment'

describe Judopay::CardPayment do
  it "should create a new payment given valid card details" do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/create.json") })

    payment = build(:card_payment)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Success")
  end

  it "should not create a new payment if the card is declined" do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/create_declined.json") })

    payment = build(:card_payment)
    payment.card_number = '4221690000004963' # Always declined
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Declined")    
  end

  it "should return a bad request exception if basic validation fails" do
      expect(lambda do
        Judopay::CardPayment.new.create
      end).to raise_error(Judopay::ValidationError)    
  end

  it "should use the configured Judo ID if one isn't provided in the payment request" do
    
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/create.json") })

    Judopay.configure do |config|
      config.judo_id = '123-456'
    end

    payment = build(:card_payment)
    payment.create

    expect(payment.valid?).to eq(true)
    expect(payment.judo_id).to eq('123-456')
  end

  it "should validate a new payment given valid card details" do
    stub_post('/transactions/payments/validate').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/validate.json") })

    payment = build(:card_payment)
    response = payment.validate

    expect(response).to be_a(Hash)
    expect(response.error_message).to include("good to go") # API could give a more helpful response here
  end  

end