require "potpourri/version"

ROOT = File.expand_path '../', __FILE__

module Potpourri
  Dir.glob(File.join ROOT, 'lib/**/*.rb').each { |f| require f }
  Dir.glob(File.join ROOT, 'models/**/*.rb').each { |f| require f }
  Dir.glob(File.join ROOT, 'extensions/**/*.rb').each { |f| require f }
end
