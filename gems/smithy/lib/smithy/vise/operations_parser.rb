# frozen_string_literal: true

module Smithy
  module Vise
    # @api private
    class OperationsParser
      RESOURCE_LIFECYCLE_KEYS = %w[create put read update delete list].freeze
      RESOURCE_OPERATION_KEYS = %w[operation collectionOperations].freeze
      RESOURCES_KEY = 'resources'

      def initialize(shapes)
        @shapes = shapes
      end

      def parse(service)
        operations = {}
        parse_service_operations(service, operations)
        parse_service_resources(service, operations)
        operations.sort_by { |k, _v| k }.to_h
      end

      private

      def parse_service_operations(service, operations)
        service.shape['operations']&.collect do |shape|
          id = shape['target']
          operations[id] = @shapes[id]
        end
      end

      def parse_service_resources(service, operations)
        service.shape['resources']&.collect do |shape|
          id = shape['target']
          parse_resource(@shapes[id], operations)
        end
      end

      def parse_resource(resource, operations)
        parse_lifecycles(resource, operations)
        parse_resource_operations(resource, operations)

        resource.shape[RESOURCES_KEY]&.collect do |shape|
          id = shape['target']
          parse_resource(@shapes[id], operations)
        end
      end

      def parse_lifecycles(resource, operations)
        RESOURCE_LIFECYCLE_KEYS.each do |key|
          next unless resource.shape.key?(key)

          id = resource.shape[key]['target']
          operations[id] = @shapes[id]
        end
      end

      def parse_resource_operations(resource, operations)
        RESOURCE_OPERATION_KEYS.each do |key|
          resource.shape[key]&.collect do |shape|
            id = shape['target']
            operations[id] = @shapes[id]
          end
        end
      end
    end
  end
end
