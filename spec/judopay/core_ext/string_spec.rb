require 'spec_helper'
require_relative '../../../lib/judopay/core_ext/string'

describe String do
  it "should convert an underscored string to camel case" do
    expect("judo_pay".camel_case).to eq('judoPay')
  end

  it "should convert an camel case string to underscored format" do
    expect("JudoPay".underscore).to eq('judo_pay')
  end

  it "should uncapitalize a word" do
    expect("JudoPay".uncapitalize).to eq('judoPay')
  end
end
