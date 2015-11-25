module Potpourri
  module ActiveRecord
    class IdentifierField < Field
      def importable?
        false
      end

      def identifier?
        true
      end
    end
  end
end
