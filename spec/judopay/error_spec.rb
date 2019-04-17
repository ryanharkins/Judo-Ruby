require 'spec_helper'
require_relative '../../lib/judopay/error'
require 'active_model'

describe Judopay::FieldError do
  it 'returns fields that was set in message' do
    e = Judopay::FieldError.new('msg', 123, 'field', 'detail')
    expect(e.to_s).to eq('Field "field" (code 123): msg')
  end
end

describe Judopay::ValidationError do
  it 'returns fields that was set' do
    errors = ActiveModel::Errors.new(nil)
    errors['some_field'] << 'some error'
    e = Judopay::ValidationError.new('Error', errors)
    expect(e.to_s).to eq("Error\nField errors:\nsome_field: some error")
  end
end

describe Judopay::APIError do
  it 'returns the fields that was set' do
    message = 'An explicitly set message'

    e = Judopay::APIError.new(message, 1, 12, 23, [])
    expect(e.message).to eq(message)
    expect(e.error_code).to eq(1)
    expect(e.status_code).to eq(12)
    expect(e.category).to eq(23)
    expect(e.field_errors).to eq([])
  end

  it 'return class name when there is no message and field errors' do
    expect(Judopay::APIError.new(nil).message).to eq('Judopay::APIError')
  end

  it 'creates valid APIError from response using factory method' do
    stub_post('/transactions/payments').
      to_return(:status => 400,
                :body => lambda { |_request| fixture('card_payments/create_bad_request.json') },
                :headers => { 'Content-Type' => 'application/json' })

    payment = build(:card_payment)

    begin
      payment.create
    rescue Judopay::APIError => e
      expect(e.status_code).to eq(400)
      expect(e.field_errors).to be_a_kind_of(Array)
      expect(e.field_errors[0]).to be_a_kind_of(Judopay::FieldError)
      expect(e.field_errors[0].code).to eq(46)
      expect(e.error_code).to eq(1)
      expect(e.category).to eq(2)
      expect(e.message).to eq("Sorry, we're unable to process your request. Please check your details and try again.\n\
Fields errors:\nField \"ExpiryDate\" (code 46): Sorry, but the expiry date entered is in the past. \
Please check your details and try again.")
    end
  end

  it 'makes error information available on the exception object for validation errors' do
    payment = Judopay::CardPayment.new

    begin
      payment.create
    rescue Judopay::ValidationError => e
      expect(e.model_errors).to be_a_kind_of(Hash)
      expect(e.message).to include('Missing required fields')
    end
  end
end
