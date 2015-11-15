require "potpourri/version"

ROOT = File.expand_path '../', __FILE__

module Potpourri
  Dir.glob(File.join ROOT, 'lib/**/*').each { |f| require f }
  Dir.glob(File.join ROOT, 'models/**/*').each { |f| require f }
end
