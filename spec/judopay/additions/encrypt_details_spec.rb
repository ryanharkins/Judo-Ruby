require 'spec_helper'
require_relative '../../../lib/judopay/models/additions/encrypt_details'

describe Judopay::EncryptDetails do
  it 'should return one use token which can be used to transact' do
    stub_get('/encryptions/paymentDetails').
      to_return(:status => 200)

    #verify response contains oneUseToken

    #verify we can use one time token to transact
  end
end
