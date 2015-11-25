module Potpourri
  class Field
    include Potpourri::Titleize

    class Unimportable < StandardError; end
    class Unexportable < StandardError; end

    attr_reader :name, :header, :export_method, :import_method

    def initialize(name, options = {})
      @export_method = options[:export_method] || name.to_sym
      @import_method = options[:import_method] || "#{ name }=".to_sym
      @header = options[:header] || titleize(name)
      @name = name.to_sym
    end

    def importable?
      true
    end

    def exportable?
      true
    end

    def import(resource, value)
      raise Unimportable unless importable?
      resource.public_send import_method, value
    end

    def export(resource)
      raise Unexportable unless exportable?
      resource.public_send export_method
    end
  end
end
