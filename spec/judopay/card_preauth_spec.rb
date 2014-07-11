require 'spec_helper'
require_relative '../../lib/judopay/models/card_preauth'

describe Judopay::CardPreauth do
  it 'should create a new preauth given valid card details' do
    stub_post('/transactions/preauths').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('card_payments/create.json') })

    payment = build(:card_preauth)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
  end

  it 'should not create a new preauth if the card is declined' do
    stub_post('/transactions/preauths').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('card_payments/create_declined.json') })

    payment = build(:card_payment)
    payment.card_number = '4221690000004963' # Always declined
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Declined')
  end

  it 'should return a bad request exception if basic validation fails' do
    expect(lambda do
      Judopay::CardPreauth.new.create
    end).to raise_error(Judopay::ValidationError)
  end
end
