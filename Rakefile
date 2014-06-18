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
    Judopay.configure do |config|
      config.api_token = ENV['JUDO_TOKEN']
      config.api_secret = ENV['JUDO_SECRET']
    end
    
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
end