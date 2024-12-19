# frozen_string_literal: true

module Smithy
  module Vise
    # Finds all operations in a service.
    class OperationIndex
      def initialize(shapes)
        @shapes = shapes
      end

      def for(service)
        operations = {}
        parse_service_operations(service, operations)
        parse_service_resources(service, operations)
        operations.sort_by { |k, _v| k }.to_h
      end

      private

      def parse_service_operations(service, operations)
        service.operations&.collect do |shape|
          id = shape['target']
          operations[id] = @shapes[id]
        end
      end

      def parse_service_resources(service, operations)
        service.resources&.collect do |shape|
          id = shape['target']
          parse_resource(@shapes[id], operations)
        end
      end

      def parse_resource(resource, operations)
        parse_lifecycles(resource, operations)
        parse_resource_operations(resource, operations)
        parse_resource_collection_operations(resource, operations)

        resource.resources&.collect do |shape|
          id = shape['target']
          parse_resource(@shapes[id], operations)
        end
      end

      def parse_lifecycles(resource, operations)
        resource.lifecycle_operations.each_value do |data|
          next unless data

          id = data['target']
          operations[id] = @shapes[id]
        end
      end

      def parse_resource_operations(resource, operations)
        resource.operations&.collect do |shape|
          id = shape['target']
          operations[id] = @shapes[id]
        end
      end

      def parse_resource_collection_operations(resource, operations)
        resource.collection_operations&.collect do |shape|
          id = shape['target']
          operations[id] = @shapes[id]
        end
      end
    end
  end
end
