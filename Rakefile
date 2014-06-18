require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'faraday'
require 'judopay'
require 'json'
require 'terminal-table'

RSpec::Core::RakeTask.new

task :default => :spec
task :test => :spec

namespace :transactions do 
  task :list do 
    configure
    
    transactions = Judopay::Transaction.all
   
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

  task :save do
    configure

    transaction = Judopay::Transaction.new
    transaction.your_consumer_reference = '123'
    transaction.your_payment_reference = '456'
    transaction.save
  end

  def configure
    Judopay.configure do |config|
      config.api_token = ENV['JUDO_TOKEN']
      config.api_secret = ENV['JUDO_SECRET']
      #config.endpoint_url = 'https://api-yourapihere-com-5oon7fxkyui4.runscope.net/path/'
    end
  end
end