require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
  add_filter 'lib/potpourri.rb'
end

require 'bundler'
Bundler.require :default, :development

require 'potpourri'

RSpec.configure do |config|

end
