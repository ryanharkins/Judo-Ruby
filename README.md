# Judopay Ruby gem [![Build Status](https://travis-ci.org/Judopay/Judo-Ruby.svg?branch=master)](https://travis-ci.org/Judopay/Judo-Ruby)
The JudoPay gem provides you with ability to integrate card payments into your Ruby and Rails projects. Judo's SDK enables a faster, simpler and more secure payment experience within your app.


## Requirements
The Judopay gem supports Ruby 1.9.3 and above (including 2.x).

## Getting started
##### 1. Integration
Add this line to your application's Gemfile:

	gem 'judopay'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install judopay

##### 2. Setup
To start using the gem, you need to pass block with your API credentials:
```ruby
require 'judopay'
Judopay.configure do |config|
	config.judo_id = '<JUDO_ID>'
	config.api_token = '<TOKEN>'
	config.api_secret = '<SECRET>'
	config.use_production = false    # set to true on production, defaults to false which is the sandbox
end
```

##### 3. Make a payment
Add model inclusion to your source code:
```ruby
require 'judopay/models/card_payment'
```
**Note:** by default we only include the minimum models in order to keep memory footprint down. You will need to include it explicitly when using each type of payment model as defined in the wiki.

To make a new payment with full card details:
```ruby
payment = Judopay::CardPayment.new(
  :judoId => '<JUDO_ID>',
  :your_consumer_reference => '<CONSUMER_REFERENCE>',
  :your_payment_reference => '<PAYMENT_REFERENCE>',
  :amount => 5.01,
  :currency => 'GBP',
  :card_number => '4976000000003436',
  :expiry_date => '12/20',
  :cv2 => '452',
  :card_address => {
    :line1 => '32 Edward Street',
    :town => 'Camborne',
    :postcode => 'TR14 8PA'
  }
)
```
**Note:** Please make sure that you are using a unique `your_consumer_reference` for each different consumer, and a unique `your_payment_reference` for each transaction.

You can check on the required fields and the format of each field in the [Judopay REST API reference](https://www.judopay.com/docs/version-52/api/restful-api/#post-card-payment).

To send the request to the API, call:
```ruby
payment_response = payment.create
```

##### 4. Check the payment result
The response will contain the full details of the transaction: (see full response [here](https://www.judopay.com/docs/v5/api-reference/restful-api/#post-card-payment)):
```ruby
{
  "receipt_id"=>"xxxxxxx",
  "type"=>"Payment",
  "created_at"=>"2016-09-23T09:28:47.1207+01:00",
  "result"=>"Success",
  "amount"=>"5.01",
  "currency"=>"GBP",
  ...
}
```
The status of the transaction can be checked to see if it was successful:
```ruby
    if payment_response.result == 'Success'
        puts 'Payment successful'
    else
        puts 'There was an issue while processing the payment'
    end
```

It's important to handle different exceptions in your code. See more details in our [error handling section](https://github.com/JudoPay/RubySdk/wiki/Error-handling). 

## Next steps
The Judopay gem supports a range of customization options. For more information on using the Judo Ruby SDK see our [wiki documentation](https://github.com/JudoPay/RubySdk/wiki). 

## License
See the [LICENSE](https://github.com/JudoPay/RubySdk/blob/master/LICENSE.txt) file for license rights and limitations (MIT).
