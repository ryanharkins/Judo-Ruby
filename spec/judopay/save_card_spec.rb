require 'spec_helper'
require_relative '../../lib/judopay/models/save_card'

describe Judopay::SaveCard do
  it 'should save a new card with valid card details' do
    stub_post('/transactions/savecard').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/save_card.json') })

    save_card = build(:save_card)
    response = save_card.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
    expect(response.type).to eq('Register')
  end

  it 'should return a bad request exception if basic validation fails' do
    expect(lambda do
      Judopay::SaveCard.new.create
    end).to raise_error(Judopay::ValidationError)
  end
end
