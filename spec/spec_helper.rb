require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'lib/potpourri.rb'
end

require 'bundler'
Bundler.require :default, :development

require 'potpourri'
require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
load File.dirname(__FILE__) + '/schema.rb'

require File.dirname(__FILE__) + '/test_class.rb'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
