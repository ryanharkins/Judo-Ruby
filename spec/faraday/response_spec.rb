require 'spec_helper'

describe Faraday::Response do
  [
    400,
    401,
    404,
    409,
    500,
    503
  ].each do |status|
    context "when response status is #{status}" do
      before do
        stub_get('/transactions').
          to_return(:status => status,
                    :body => lambda { |_request| JSON.generate('errorType' => status) },
                    :headers => { 'Content-Type' => 'application/json' })
      end

      it 'should raise APIError exception' do
        expect(lambda do
          Judopay::Transaction.all
        end).to raise_error(Judopay::APIError)
      end
    end
  end
end
