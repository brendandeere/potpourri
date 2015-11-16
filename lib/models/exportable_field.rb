module Potpourri
  class ExportableField < Field
    def importable?
      false
    end
  end
end
