require 'spec_helper'
require_relative '../../lib/judopay/models/register_card'

describe Judopay::RegisterCard do
  it 'should register a new card with valid card details' do
    stub_post('/transactions/registercard').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/register_card.json') })

    register_card = build(:register_card)
    response = register_card.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
    expect(response.type).to eq('PreAuth')
    expect(response.amount).to eq('1.01')
  end

  it 'should return a bad request exception if basic validation fails' do
    expect(lambda do
      Judopay::RegisterCard.new.create
    end).to raise_error(Judopay::ValidationError)
  end
end
