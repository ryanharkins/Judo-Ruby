# Making a payment - Ruby

First, configure Judopay with your authentication credentials (as described in the Getting Started guide).

Judopay.configure do |config|
	config.api_token = 'your-token'
  config.api_secret = 'your-secret'
end

To make a new payment with full card details, create a new Judopay::Payment. You can check on the required fields and the format of each field in the _Judopay REST API reference_.

transaction = Judopay::Payment.new(
  :your_consumer_reference => '123',
  :your_payment_reference => '456',
  :judo_id => '123-456-789',
  :amount => 5.01,
  :card_number => '4976000000003436',
  :expiry_date => '12/15',
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

To send the request to the API, call:

response = payment.create

If the payment is successful, you'll receive a response like this:

#<Judopay::Mash amount=5.01 appears_on_statement_as="JudoPay/XXX" card_details=#<Judopay::Mash card_lastfour="3436" card_token="WidQ0QXs4VMloCCerfGFHQkLVFwbwjVc" card_type=1 end_date="1215"> consumer=#<Judopay::Mash consumer_token="rFl6UUihdSfpJt3x" your_consumer_reference="123"> created_at="2014-07-08T15:49:10.8587+01:00" currency="GBP" judo_id=100978394 merchant_name="XXXX" message="AuthCode: 570320" net_amount=5.01 original_amount=5.01 receipt_id="465377" result="Success" type="Payment">

The Judopay::Mash object behaves like a traditional Hash, but with extra special powers. See:

http://www.intridea.com/blog/2008/4/12/mash-mocking-hash-for-total-poser-objects

## Error handling

When making a payment, there are a number of different scenarios that can arise. It is important to handle all of the different exceptions in your code.

begin
  response = payment.create
rescue Judopay::ValidationError => e
	puts e.message
	puts e.model_errors.inspect # Hash of validation errors
rescue Judopay::BadRequest => e
  # Invalid parameters were supplied to Judopay's API
	puts e.message
	puts e.model_errors.inspect # Hash of validation errors
rescue Judopay::NotAuthorized => e
  # You're not authorized to make the request - check credentials and permissions in the Judopay portal
rescue Judopay::NotFound => e
  # The resource was not found
rescue Judopay::Conflict => e
  # When does this happen?
rescue Judopay::Error => e
  # There was a problem connecting to the API
rescue => e
  # A problem occurred outside the Judopay gem
end

## Logging

To help you debug your Judopay integration, you can attach a logger to the gem.

For example, to log debug messages to the file 'log.txt':

logger = Logger.new('log.txt')
logger.level = Logger::DEBUG
Judopay.configure do |config|
	config.logger = logger
end

If you're using Rails, you use the built-in logger to write to your existing application log file:

Judopay.configure do |config|
	config.logger = Rails.logger
end