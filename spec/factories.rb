models = %w(card_payment card_preauth collection refund token_payment token_preauth)
models.each { |model| require_relative '../lib/judopay/models/' + model }

FactoryGirl.define do
  trait :valid_card_details do 
    your_consumer_reference 123
    your_payment_reference 456
    judo_id '123-456'
    amount 1.01
    card_number '4976000000003436'
    expiry_date '12/15'
    cv2 452
  end

  trait :valid_token_details do 
    your_consumer_reference '123'
    your_payment_reference '456'
    judo_id '123-456'
    amount 1.01
    consumer_token '3UW4DV9wI0oKkMFS'
    card_token 'SXw4hnv1vJuEujQR'
    cv2 '452'
  end

  trait :valid_judo_id do 
    judo_id '123-456'
  end

  trait :valid_collection_or_refund_details do
    receipt_id '1234'
    amount 1.01
    your_payment_reference 'payment12412312'
  end

  factory :card_payment, :class => Judopay::CardPayment do
    valid_card_details
    valid_judo_id
  end

  factory :card_preauth, :class => Judopay::CardPreauth do
    valid_card_details
    valid_judo_id
  end

  factory :collection, :class => Judopay::Collection do
    valid_collection_or_refund_details
  end

  factory :refund, :class => Judopay::Refund do
    valid_collection_or_refund_details
  end

  factory :token_payment, :class => Judopay::TokenPayment do
    valid_token_details
    valid_judo_id
  end

  factory :token_preauth, :class => Judopay::TokenPreauth do
    valid_token_details
    valid_judo_id
  end  
end