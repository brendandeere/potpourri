module Potpourri
  module Titleize
    def titleize(str)
      str.to_s.split(/ |\_/).map(&:capitalize).join(" ")
    end
  end
end
