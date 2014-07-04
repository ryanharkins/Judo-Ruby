require 'spec_helper'
require_relative '../../lib/judopay/models/preauth'

describe Judopay do
  it "should use the production endpoint if use_production is true" do
    expect(Judopay.configuration.endpoint_url).to include('sandbox')

    Judopay.configure do |config|
      config.use_production = true
    end

    expect(Judopay.configuration.endpoint_url).to include('production')

    # Reset to sandbox for other tests
    Judopay.configure do |config|
      config.use_production = false
    end    
  end
end