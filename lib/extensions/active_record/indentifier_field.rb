module Potpourri
  module ActiveRecord
    class IdentifierField < ExportableField
      def identifier?
        true
      end
    end
  end
end
