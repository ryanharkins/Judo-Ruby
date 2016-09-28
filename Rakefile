require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake/testtask'

RSpec::Core::RakeTask.new

Rake::TestTask.new do |t|
  raise 'Please setup JUDO_* environment vars' unless ENV['JUDO_API_ID'] && ENV['JUDO_API_TOKEN'] && ENV['JUDO_API_SECRET']
  t.libs << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :code_check do
  sh 'rubocop'
  Rake::Task['spec'].invoke
  Rake::Task['test'].invoke
end

# check code before build
task :build => :code_check
task :default => :build
