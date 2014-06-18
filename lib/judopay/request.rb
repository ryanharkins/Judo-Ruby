require 'openssl'
require 'json'

module Judopay
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, signature=false, raw=false, unformatted=false)
      request(:get, path, options, signature, raw, unformatted)
    end

    # Perform an HTTP POST request
    def post(path, options={}, signature=false, raw=false, unformatted=false)
      request(:post, path, options, signature, raw, unformatted)
    end

    # Perform an HTTP PUT request
    def put(path, options={},  signature=false, raw=false, unformatted=false)
      request(:put, path, options, signature, raw, unformatted)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, signature=false, raw=false, unformatted=false)
      request(:delete, path, options, signature, raw, unformatted)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, signature=false, raw=false, unformatted=false)
      response = connection(raw).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = JSON.generate(options) unless options.empty?
        end
      end
      return response if raw
      return Response.create(response.body)
    end
  end
end