require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'faraday'
require 'judopay'
require 'json'
require 'terminal-table'
require_relative 'lib/judopay/models/transaction'
require_relative 'lib/judopay/models/card_payment'
require_relative 'lib/judopay/models/card_preauth'
require_relative 'lib/judopay/models/preauth'
require_relative 'lib/judopay/models/refund'

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec

namespace :transactions do 
  task :all do 
    configure
    
    transactions = Judopay::Refund.all(
      :sort => 'time-ascending',
      :offset => 1,
      :page_size => 30
    )

    puts transactions.inspect
    puts transactions['resultCount'].to_s + " results\n"
    
    transactions['results'].each do |result|
      rows = []      
      result.each do |key,value|
        rows.push([key, value.inspect])
      end
      
      puts Terminal::Table.new :rows => rows
    end
  end

  task :create do
    configure

    card_address = Judopay::CardAddress.new(
      :line1 => '32 Edward Street',
      :town => 'Camborne',
      :postcode => 'TR14 8PA'
    )

    transaction = Judopay::CardPreauth.new(
      :your_consumer_reference => '123',
      :your_payment_reference => '456',
      :judo_id => ENV['JUDO_ID'],
      :amount => 5.01,
      :card_number => '4976000000003436',
      :expiry_date => '12/15',
      :cv2 => '452',
      :card_address => card_address,
      :consumer_location => {
        :latitude => 51.5033630,
        :longitude => -0.1276250
      }
    )

    response = transaction.create
    puts response.inspect
  end

  def configure
    Judopay.configure do |config|
      config.api_token = ENV['JUDO_TOKEN']
      config.api_secret = ENV['JUDO_SECRET']
      #config.endpoint_url = 'https://api-yourapihere-com-5oon7fxkyui4.runscope.net/path/'
    end
  end
end