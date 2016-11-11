# Judopay Ruby gem [![Build Status](https://travis-ci.org/Judopay/Judo-Ruby.svg?branch=master)](https://travis-ci.org/Judopay/Judo-Ruby)
The JudoPay gem provides you with ability to integrate card payments into your Ruby and Rails projects. Judo's SDK enables a faster, simpler and more secure payment experience within your app.
##### **\*\*\*Due to industry-wide security updates, versions below 2.0 of this SDK will no longer be supported after 1st Oct 2016. For more information regarding these updates, please read our blog [here](http://hub.judopay.com/pci31-security-updates/).*****

## Requirements
The Judopay gem supports Ruby 1.9.3 and above (including 2.0.x and 2.1.x).

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
	Judopay.configure do |config|
	  config.judo_id = 'your-judo-id'
	  config.api_token = 'your-token'
	  config.api_secret = 'your-secret'
	  config.use_production = false    # set to true on production, defaults to false which is the sandbox
	end
```

##### 3. Make a payment
To make a new payment with full card details:
```ruby
payment = Judopay::CardPayment.new(
  :judoId => 'your_judo_id',
  :your_consumer_reference => 'xxxxxxxx',
  :your_payment_reference => 'xxxxxxxx',
  :amount => 5.01,
  :currency => 'GBP',
  :card_number => '4976000000003436',
  :expiry_date => '12/20',
  :cv2 => '452',
  :card_address => {
    :line1 => '32 Edward Street',
    :town => 'Camborne',
    :postcode => 'TR14 8PA'
  },
  :consumer_location => {
    :latitude => 51.5033630,
    :longitude => -0.1276250
  }
)
```
**Note:** Please make sure that you are using a unique Consumer Reference for each different consumer, and a unique Payment Reference for each transaction.

You can check on the required fields and the format of each field in the [Judopay REST API reference](https://www.judopay.com/docs/version-52/api/restful-api/#post-card-payment).

To send the request to the API, call:
```ruby
    payment_response = payment.create
```

##### 4. Check the payment result
If the payment is successful, you'll `payment_response` variable will contain Mash like this (see full response [here](https://www.judopay.com/docs/v5/api-reference/restful-api/#post-card-payment)):
```ruby
{
  "receipt_id"=>"xxxxxxx",
  "type"=>"Payment",
  "created_at"=>"2016-09-23T09:28:47.1207+01:00",
  "result"=>"Success",
  ...
  "amount"=>"5.01",
  "currency"=>"GBP",
  ...
}
```
So your check code might look like this:
```ruby
    if result_payment.result == 'Success'
        puts 'Payment successful'
    else
        puts 'There were some problems while processing your payment'
    end
```

Also important to handle different exceptions in your code. See more details in our [error handling section](https://github.com/JudoPay/RubySdk/wiki/Error-handling). 

## Next steps
The Judopay gem supports a range of customization options. For more information on using judo see our [wiki documentation](https://github.com/JudoPay/RubySdk/wiki). 

## License
See the [LICENSE](https://github.com/JudoPay/RubySdk/blob/master/LICENSE.txt) file for license rights and limitations (MIT).
