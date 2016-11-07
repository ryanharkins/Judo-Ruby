models = %w(
  card_payment
  card_preauth
  collection
  refund
  token_payment
  token_preauth
  web_payments/payment
  market/collection
  market/refund
  save_card
  register_card
  void
)
models.each { |model| require_relative '../lib/judopay/models/' + model }
require 'securerandom'

FactoryGirl.define do
  trait :payment_details do
    your_consumer_reference 123
    sequence :your_payment_reference do |n|
      SecureRandom.hex(21) + n.to_s
    end
    amount 1.01
  end

  trait :valid_card do
    card_number '4976000000003436'
    expiry_date '12/20'
    cv2 452
  end

  trait :declined_card do
    card_number '4221690000004963'
    expiry_date '12/20'
    cv2 125
  end

  trait :valid_token_details do
    consumer_token '3UW4DV9wI0oKkMFS'
    card_token 'SXw4hnv1vJuEujQR'
    cv2 452
  end

  trait :valid_judo_id do
    judo_id '100435-197'
  end

  trait :valid_collection_or_refund_details do
    receipt_id '1234'
    amount 1.01
    sequence :your_payment_reference do |n|
      SecureRandom.hex(21) + n.to_s
    end
  end

  trait :client_ip_address_and_user_agent do
    client_ip_address '127.0.0.1'
    client_user_agent 'Mozilla/5.0 (Windows NT 6.2; Win64; x64)...'
  end

  factory :card_payment, :class => Judopay::CardPayment do
    payment_details
    valid_judo_id
    valid_card
    currency 'GBP'

    trait :declined do
      card_number '4221690000004963'
      cv2 125
    end
  end

  factory :card_preauth, :class => Judopay::CardPreauth do
    payment_details
    valid_card
    valid_judo_id
    currency 'GBP'

    trait :declined do
      card_number '4221690000004963'
      cv2 125
    end
  end

  factory :collection, :class => Judopay::Collection do
    valid_collection_or_refund_details
  end

  factory :refund, :class => Judopay::Refund do
    valid_collection_or_refund_details
  end

  factory :token_payment, :class => Judopay::TokenPayment do
    payment_details
    valid_token_details
    valid_judo_id
    currency 'GBP'
  end

  factory :token_preauth, :class => Judopay::TokenPreauth do
    payment_details
    valid_token_details
    valid_judo_id
    currency 'GBP'
  end

  factory :web_payment, :class => Judopay::WebPayments::Payment do
    valid_judo_id
    payment_details
    client_ip_address_and_user_agent

    partner_service_fee 1.00
  end

  factory :web_preauth, :class => Judopay::WebPayments::Payment do
    valid_judo_id
    payment_details
    client_ip_address_and_user_agent

    partner_service_fee 1.00
  end

  factory :market_collection, :class => Judopay::Market::Collection do
    valid_collection_or_refund_details
  end

  factory :market_refund, :class => Judopay::Market::Refund do
    valid_collection_or_refund_details
  end

  factory :save_card, :class => Judopay::SaveCard do
    valid_card

    your_consumer_reference 123
  end

  factory :register_card, :class => Judopay::RegisterCard do
    payment_details
    valid_card
    valid_judo_id
    currency 'GBP'

    trait :declined do
      card_number '4221690000004963'
      cv2 125
    end
  end

  factory :void, :class => Judopay::Void do
    valid_collection_or_refund_details
  end
end
