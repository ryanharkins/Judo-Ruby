require 'spec_helper'
require_relative '../../lib/judopay/models/token_preauth'

describe Judopay::TokenPayment do
  it "should create a new payment given a valid payment token and card token" do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |request| fixture("token_payments/create.json") })

    payment = Judopay::TokenPayment.new(
      :your_consumer_reference => '123',
      :your_payment_reference => '456',
      :judo_id => '123-456',
      :amount => 1.01,
      :consumer_token => '3UW4DV9wI0oKkMFS',
      :card_token => 'SXw4hnv1vJuEujQR',
      :cv2 => '452'
    )
    
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq("Success")
  end

  it "should return a bad request exception if basic validation fails" do
      expect(lambda do
        Judopay::TokenPayment.new.create
      end).to raise_error(Judopay::BadRequest)    
  end
end