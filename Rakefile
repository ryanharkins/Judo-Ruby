require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "faraday"
require "judopay"

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec

namespace :faraday do
  desc "Test Faraday API integration"
  task :test do
    judo_endpoint = 'https://partnerapi.judopay-sandbox.com'
    judo_token = ENV['JUDO_TOKEN']
    judo_secret = ENV['JUDO_SECRET']

    conn = Faraday.new(:url => judo_endpoint) do |c|
      #c.use Faraday::Request::UrlEncoded  # encode request params as "www-form-urlencoded"
      c.use Faraday::Response::Logger     # log request & response to STDOUT
      c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
    end

    conn.headers['API-Version'] = Judopay::API.api_version
    conn.headers['Accept'] = 'application/json'
    #conn.headers['Authorization'] = 'Basic ' + Base64.encode64([judo_token, judo_secret].join(':')).gsub!("\n", '')
    conn.basic_auth(judo_token, judo_secret)

    response = conn.get '/transactions'
    puts response.body
  end
end