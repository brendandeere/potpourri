module Potpourri
  module ActiveRecord
    module FieldHelpers
      def self.included(mod)
        mod.extend ClassMethods
      end

      module ClassMethods
        def id_field(name, options = {})
          IdentifierField.new name, options
        end
      end
    end
  end
end
