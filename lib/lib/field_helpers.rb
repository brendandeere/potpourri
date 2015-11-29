module Potpourri
  module FieldHelpers
    def self.included(mod)
      mod.extend ClassMethods
    end

    module ClassMethods
      def field(name, options = {})
        Field.new name, options
      end

      def importable_field(name, options = {})
        ImportableField.new name, options
      end

      def exportable_field(name, options = {})
        ExportableField.new name, options
      end
    end
  end
end
