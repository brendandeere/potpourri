require "potpourri/version"
require 'csv'

ROOT = File.expand_path '../', __FILE__
Dir.glob(File.join ROOT, 'potpourri/models/**/*').each { |f| require f }
Dir.glob(File.join ROOT, 'potpourri/lib/**/*').each { |f| require f }

module Potpourri
  # Your code goes here...
end
