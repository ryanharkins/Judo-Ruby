# Version 2.0.0

#### Modifications
In version 2.0 we changed error model and added couple of new models. 

We decreased amount of Exceptions to two:
 - Local validation error (ValidationError)
 - ApiException which arise when Judo REST API returns error.

So at first you need to update your error handling principle. See example at [Error handling](https://github.com/JudoPay/RubySdk/wiki/Error-handling).

#### Additions
 - ```validate``` method added to [Collect](https://github.com/JudoPay/RubySdk/wiki/Collecting-on-a-Pre-Authorization#validating-the-collection) and [Refund](https://github.com/JudoPay/PhpSdk/wiki/Refund-a-Payment#validating-the-refund) models so now you could check yours transactions.
 - [Void model](https://github.com/JudoPay/RubySdk/wiki/Voiding-requests)
 - [Register card model](https://github.com/JudoPay/RubySdk/wiki/Registering-a-Card)
 - [Save card model](https://github.com/JudoPay/RubySdk/wiki/Saving-a-Card)
 - Integration tests
