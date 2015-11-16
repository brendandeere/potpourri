module Potpourri
  module ReportConfigs
    def self.included(mod)
      mod.extend ClassMethods
    end

    def fields
      self.class.instance_variable_get '@fields'
    end

    def resource_class
      self.class.instance_variable_get '@klass'
    end

    module ClassMethods
      def fields(fields)
        @fields = fields
      end

      def resource_class(klass)
        @klass = klass
      end
    end
  end
end
