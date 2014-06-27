require 'spec_helper'
require_relative '../../lib/judopay/error'

describe Judopay::Error do
  it "returns a 'message' equal to the class name if the message is not set, because 'message' should not be nil" do
    e = Judopay::Error.new
    expect(e.message).to eq('Judopay::Error')
  end

  it "returns the 'message' that was set" do
    e = Judopay::Error.new
    message = "An explicitly set message"
    e.message = message
    expect(e.message).to eq(message)
  end

  it "contains exceptions in Judopay" do
    expect(Judopay::BadRequest.new).to be_a_kind_of(Judopay::Error)
  end
end