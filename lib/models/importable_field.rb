module Potpourri
  class ImportableField < Field
    def exportable?
      false
    end
  end
end
