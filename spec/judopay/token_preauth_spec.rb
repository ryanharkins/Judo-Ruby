require 'spec_helper'
require_relative '../../lib/judopay/models/token_preauth'

describe Judopay::TokenPreauth do
  it 'should create a new preauth given a valid payment token and card token' do
    stub_post('/transactions/preauths').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('token_payments/create.json') })

    payment = build(:token_preauth)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
  end

  it 'should return a bad request exception if basic validation fails' do
    expect(lambda do
      Judopay::TokenPreauth.new.create
    end).to raise_error(Judopay::ValidationError)
  end
end
