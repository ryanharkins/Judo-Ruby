require 'spec_helper'
require_relative '../../lib/judopay/models/card_address'

describe Judopay::CardAddress do
  it "should not allow querying of the API if a resource path isn't set on the model" do
    expect(lambda do
      Judopay::CardAddress.all
    end).to raise_error(Judopay::Error)
  end
end
