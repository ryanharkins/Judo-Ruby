require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'faraday'
require 'judopay'
require 'json'
require 'terminal-table'
require 'logger'
require_relative 'lib/judopay'
require_relative 'lib/judopay/models/transaction'
require_relative 'lib/judopay/models/card_payment'
require_relative 'lib/judopay/models/card_preauth'
require_relative 'lib/judopay/models/preauth'
require_relative 'lib/judopay/models/refund'
require_relative 'lib/judopay/models/web_payments/payment'
require_relative 'lib/judopay/models/web_payments/preauth'

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec

namespace :transactions do 
  task :all do 
    configure
    
    transactions = Judopay::Payment.all(
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
      #:your_consumer_reference => '123',
      #:your_payment_reference => '456',
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

    begin
      response = transaction.create
      puts response.inspect
    rescue Judopay::ValidationError => e
      puts e.inspect
      puts e.model_errors.inspect
    rescue Judopay::BadRequest => e
      puts e.inspect
      puts e.model_errors.inspect  
    end
  end

  task :log do
    configure
    Judopay.log(Logger::DEBUG, 'There was a problem')
  end

  namespace :web do
    task :create do
      configure
      payment = Judopay::WebPayments::Preauth.new(
        :your_consumer_reference => '123',
        :your_payment_reference => '456',
        :judo_id => ENV['JUDO_ID'],
        :amount => 1.01,
        :client_ip_address => '127.0.0.1',
        :client_user_agent => 'Mosaic 1.0',
        :partner_service_fee => 0.10
      )
      
      begin
        response = payment.create
        puts response.inspect
      rescue Judopay::ValidationError => e
        puts e.inspect
        puts e.model_errors.inspect
      rescue Judopay::BadRequest => e
        puts e.inspect
        puts e.model_errors.inspect  
      end
    end

    task :find do
      configure
      response = Judopay::WebPayments::Payment.find('3gcAAAcAAAADAAAADgAAADzZUfp-yHvi_odtZ6yiMCY6e4PRh9voAeYv-dfSdwwthlMc5Q')
      puts response.inspect
    end
  end

  def configure
    logger = Logger.new('log.txt')
    logger.level = Logger::DEBUG

    Judopay.configure do |config|
      config.api_token = ENV['JUDO_TOKEN']
      config.api_secret = ENV['JUDO_SECRET']
      config.logger = logger
      #config.endpoint_url = 'https://api-yourapihere-com-5oon7fxkyui4.runscope.net/path/'
    end
  end
end