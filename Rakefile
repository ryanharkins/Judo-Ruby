require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'faraday'
require 'judopay'
require 'json'
require 'vcr'
require 'terminal-table'

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec

namespace :transactions do 
  task :list do 
    Judopay.configure do |config|
      config.api_token = ENV['JUDO_TOKEN']
      config.api_secret = ENV['JUDO_SECRET']
    end
    
    transactions = Judopay::Transaction.all
    puts transactions['resultCount'].to_s + " results\n"
    
    rows = []
    transactions['results'].each do |result|
      result.each do |key,value|
        rows.push([key, value.inspect])
      end
    end

    puts Terminal::Table.new :rows => rows
  end
end

namespace :faraday do
  desc "Test Faraday API integration (GET)"
  task :get do
    conn = get_connection

    response = conn.get '/transactions'
    puts response.body
  end

  desc "Test Faraday API integration (POST)"
  task :post do
    conn = get_connection

    body_json = '{
      "yourConsumerReference":"bjk-235452-1214",
      "yourPaymentReference":"judopay-testing-1214",
      "yourPaymentMetaData":{
        "test":"data"
      },
      "judoId":"100978394",
      "amount":1.01,
      "cardNumber":"4976000000003436",
      "expiryDate":"12/15",
      "cv2":"452",
      "cardAddress":{
        "line1":"242 Acklam Road",
        "line2":"Westbourne Park",
        "line3":"",
        "town":"London",
        "postCode":"W10 5JJ"
      },
      "consumerLocation":{
        "latitude":51.5214541344954,
        "longitude":-0.203098409696038
      },
      "mobileNumber":"07100000000",
      "emailAddress":"cardholder@test.com"
    }'

    response = conn.post '/transactions/payments', body_json do |request|
      puts request.headers.inspect
      puts request.body.inspect
    end

    puts response.body
  end

  def get_connection
    judo_endpoint = 'https://partnerapi.judopay-sandbox.com'
    judo_token = ENV['JUDO_TOKEN']
    judo_secret = ENV['JUDO_SECRET']

    VCR.configure do |c|
      c.allow_http_connections_when_no_cassette = true
      c.hook_into :faraday
    end
    
    conn = Faraday.new(:url => judo_endpoint) do |c|
      c.use Faraday::Request::UrlEncoded  # encode request params as "www-form-urlencoded"
      c.use Faraday::Response::Logger     # log request & response to STDOUT
      c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
      c.use VCR::Middleware::Faraday do |cassette|
        cassette.name    'faraday_example'
        cassette.options :record => :new_episodes
      end      
    end

    conn.headers['API-Version'] = Judopay::API.api_version
    conn.headers['Accept'] = 'application/json'
    conn.headers['Content-Type'] = 'application/json' # required!   
    conn.basic_auth(judo_token, judo_secret)

    conn
  end
end