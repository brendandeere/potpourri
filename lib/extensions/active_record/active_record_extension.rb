module Potpourri
  module ActiveRecordExtension
    def self.included(mod)
      raise NotAReport unless mod.ancestors.include?(Report)
      mod.extend ClassMethods
    end

    class MissingIdentifierField < StandardError; end
    class RecordNotFound < StandardError; end

    def can_update_existing_records?
      self.class.instance_variable_get '@can_update_existing_records'
    end

    def can_create_new_records?
      self.class.instance_variable_get '@can_create_new_records'
    end


    def identifier_field
      fields.detect &:identifier?
    end

    def import
      resources = super
      resources.each { |resource| resource.save! }
    end

    private

    def fetch_resource(row)
      raise MissingIdentifierField unless importable?

      return find_record(row) unless can_create_new_records?
      return resource_class.new unless can_update_existing_records?

      resource = resource_class.find_or_initialize_by id_params(row)
    end

    def find_record(row)
      resource = resource_class.find_by! id_params(row)
    end

    def importable?
      (can_create_new_records? || can_update_existing_records?) && identifier_field
    end

    def id_params(row)
      Hash[identifier_field.export_method, row[identifier_field.header]]
    end

    module ClassMethods
      def create_new_records(flag = true)
        @can_create_new_records = flag
      end

      def update_existing_records(flag = true)
        @can_update_existing_records = flag
      end
    end
  end
end
