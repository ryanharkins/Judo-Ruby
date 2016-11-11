require 'spec_helper'
require 'json'
require_relative '../../lib/judopay/models/apple_payment'

describe Judopay::ApplePayment do
  it 'should create a new payment given pk_payment object' do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/apple_payment.json') })

    payment = build(:apple_payment)
    response = payment.create

    expect(response).to be_a(Hash)
    expect(response.result).to eq('Success')
  end

  it 'should return a bad request exception if basic validation fails' do
    expect(lambda do
      Judopay::ApplePayment.new.create
    end).to raise_error(Judopay::ValidationError)
  end

  it 'should use the configured Judo ID if one isn\'t provided in the payment request' do
    stub_post('/transactions/payments').
      to_return(:status => 200,
                :body => lambda { |_request| fixture('transactions/apple_payment.json') })

    Judopay.configure do |config|
      config.judo_id = '123-456'
    end

    payment = build(:apple_payment, :judo_id => nil)
    payment.create

    expect(payment.valid?).to eq(true)
    expect(payment.judo_id).to eq('123-456')
  end

  it 'properly coerces pk_payment field from_json' do
    json_string = '{"pkPayment":{"token":{"paymentInstrumentName":"Visa XXXX","paymentNetwork":"Visa","paymentData"'\
':{"version":"EC_v1","data":"SomeBase64encodedData","signature":"SomeBase64encodedData","header":{"ephemeralPublicKey"'\
':"someKey","publicKeyHash":"someKey","transactionId":"someId"}}},"billingAddress":1,"shippingAddress":2}}'
    pk_payment = Judopay::PkPayment.new(
      :token => Judopay::PkPaymentToken.new(
        :payment_instrument_name => 'Visa XXXX',
        :payment_network => 'Visa',
        :payment_data => {
          'version' => 'EC_v1',
          'data' => 'SomeBase64encodedData',
          'signature' => 'SomeBase64encodedData',
          'header' => {
            'ephemeral_public_key' => 'someKey',
            'public_key_hash' => 'someKey',
            'transaction_id' => 'someId'
          }
        }
      ),
      :billing_address => '1',
      :shipping_address => '2'
    )

    payment = build(:apple_payment, :pk_payment => json_string)
    expect(payment.pk_payment).to be == pk_payment
  end

  it 'should raise an error when bad pk_payment passed' do
    expect(lambda do
      Judopay::ApplePayment.new(:pk_payment => '{"someInvalidJson}}')
    end).to raise_error(Judopay::ValidationError, format(Judopay::PkPayment::WRONG_JSON_ERROR_MESSAGE, 'Judopay::PkPayment'))

    expect(lambda do
      Judopay::ApplePayment.new(:pk_payment => 1)
    end).to raise_error(Judopay::ValidationError, format(Judopay::PkPayment::WRONG_OBJECT_ERROR_MESSAGE, 'Judopay::PkPayment'))

    expect(lambda do
      build(:apple_payment, :pk_payment => '{"valid_json":"Without token field"}').create
    end).to raise_error(Judopay::ValidationError)
  end
end
