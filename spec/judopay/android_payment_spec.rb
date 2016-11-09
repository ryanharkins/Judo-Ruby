require 'spec_helper'
require_relative '../../lib/judopay/models/android_payment'

describe Judopay::AndroidPayment do
  it 'should create a new payment given wallet object' do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/android_payment.json') })

    payment = build(:android_payment)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
  end

  it 'should return a bad request exception if basic validation fails' do
    expect(lambda do
      Judopay::AndroidPayment.new.create
    end).to raise_error(Judopay::ValidationError)
  end

  it 'should use the configured Judo ID if one isn\'t provided in the payment request' do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/android_payment.json') })

    Judopay.configure do |config|
      config.judo_id = '123-456'
    end

    payment = build(:android_payment, :judo_id => nil)
    payment.create

    expect(payment.valid?).to eq(true)
    expect(payment.judo_id).to eq('123-456')
  end

  it 'properly coerces wallet field from_json' do
    json_string = '{"wallet":{"encryptedMessage":"SomeBase64encodedData","environment":1,'\
      '"ephemeralPublicKey":"SomeBase64encodedData","googleTransactionId":"someId",'\
      '"instrumentDetails":"1234","instrumentType":"VISA","publicKey":"SomeBase64encodedData",'\
      '"tag":"SomeBase64encodedData","version":1}}'

    wallet = Judopay::Wallet.new(
      :encrypted_message => 'SomeBase64encodedData',
      :environment => 1,
      :ephemeral_public_key => 'SomeBase64encodedData',
      :google_transaction_id => 'someId',
      :instrument_details => '1234',
      :instrument_type => 'VISA',
      :publicKey => 'SomeBase64encodedData',
      :tag => 'SomeBase64encodedData',
      :version => 1
    )

    payment = build(:android_payment, :wallet => json_string)
    expect(payment.wallet).to be == wallet
  end

  it 'should raise an error when bad wallet passed' do
    expect(lambda do
      Judopay::AndroidPayment.new(:wallet => '{"someInvalidJson}}')
    end).to raise_error(Judopay::ValidationError, format(Judopay::Wallet::WRONG_JSON_ERROR_MESSAGE, 'Judopay::Wallet'))

    expect(lambda do
      Judopay::AndroidPayment.new(:wallet => 1)
    end).to raise_error(Judopay::ValidationError, format(Judopay::Wallet::WRONG_OBJECT_ERROR_MESSAGE, 'Judopay::Wallet'))

    expect(lambda do
      build(:android_payment, :wallet => '{"valid_json":"Without token field"}').create
    end).to raise_error(Judopay::ValidationError)
  end
end
