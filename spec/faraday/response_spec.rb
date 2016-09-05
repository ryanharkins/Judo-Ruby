require 'spec_helper'

describe Faraday::Response do
  {
    400 => Judopay::BadRequest,
    401 => Judopay::NotAuthorized,
    404 => Judopay::NotFound,
    409 => Judopay::Conflict,
    500 => Judopay::InternalServerError,
    503 => Judopay::ServiceUnavailable
  }.each do |status, exception|
    context "when response status is #{status}" do
      before do
        stub_get('/transactions').
          to_return(:status => status,
                    :body => lambda { |_request| JSON.generate('errorType' => status) },
                    :headers => { 'Content-Type' => 'application/json' })
      end

      it "should raise #{exception.name} error" do
        expect(lambda do
          Judopay::Transaction.all
        end).to raise_error(exception)
      end
    end
  end
end
