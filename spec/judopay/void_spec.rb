require 'spec_helper'
require_relative '../../lib/judopay/models/void'

describe Judopay::Void do
  it 'should create new void with valid details' do
    stub_post('/transactions/voids').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/void.json') })

    void = build(:void)
    response = void.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
    expect(response.type).to eq('VOID')
    expect(response.original_amount).to eq('1.02')
  end

  it 'should return a bad request exception if basic validation fails' do
    expect(lambda do
      Judopay::Void.new.create
    end).to raise_error(Judopay::ValidationError)
  end
end
