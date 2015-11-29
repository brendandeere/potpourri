require 'csv'

module Potpourri
  class Report
    include ReportConfigs
    include FieldHelpers

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def headers
      fields.map &:header
    end

    def import
      CSV.read(path, headers: true, converters: :numeric).map do |row|
        resource = fetch_resource(row)

        importable_fields.each do |field|
          field.import resource, row[field.header]
        end

        resource
      end
    end

    def export(collection)
      CSV.open(path, 'w') do |csv|
        csv << headers

        collection.each do |item|
          csv << exportable_fields.map { |field| field.export item }
        end

        csv
      end
    end

    private

    def importable_fields
      fields.select &:importable?
    end

    def exportable_fields
      fields.select &:exportable?
    end

    def fetch_resource(row)
      resource_class.new
    end
  end
end
