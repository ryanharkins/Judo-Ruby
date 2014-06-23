require 'spec_helper'
require_relative '../../lib/judopay/models/card_address'

describe Judopay::CardAddress do
  it "should not allow querying of the API without a resource path" do
      expect(lambda do
        Judopay::CardAddress.all
      end).to raise_error(Judopay::Error)    
  end
end