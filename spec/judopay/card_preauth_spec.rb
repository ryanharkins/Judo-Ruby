require 'spec_helper'
require_relative '../../lib/judopay/models/card_preauth'

describe Judopay::CardPreauth do
  it "should create a new preauth given valid card details" do
    stub_post('/transactions/preauths').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/create.json") })

    payment = Judopay::CardPreauth.new(
      :your_consumer_reference => '123',
      :your_payment_reference => '456',
      :judo_id => '123-456',
      :amount => 1.01,
      :card_number => '4976000000003436',
      :expiry_date => '12/15',
      :cv2 => '452'
    )
    
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Success")
  end

  it "should not create a new preauth if the card is declined" do
    stub_post('/transactions/preauths').
      to_return(:status => 200,
                :body => lambda { |request| fixture("card_payments/create_declined.json") })

    payment = Judopay::CardPreauth.new(
      :your_consumer_reference => '123',
      :your_payment_reference => '456',
      :judo_id => '123-456',
      :amount => 1.01,
      :card_number => '4221690000004963',
      :expiry_date => '12/15',
      :cv2 => '452'
    )
    
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Declined")    
  end

  it "should return a bad request exception if basic validation fails" do
      expect(lambda do
        Judopay::CardPreauth.new.create
      end).to raise_error(Judopay::BadRequest)    
  end
end