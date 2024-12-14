# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a Smithy model.
    class Model
      # @api private
      RESOURCE_LIFECYCLE_KEYS = %w[create put read update delete list].freeze
      # @api private
      RESOURCE_OPERATION_KEYS = %w[operation collectionOperations].freeze
      # @api private
      RESOURCES_KEY = 'resources'

      def initialize(model)
        Smithy::Weld.descendants.each { |w| w.preprocess(model) }
        @version = model['smithy']
        @shapes = parse_shapes(model['shapes'])
      end

      # @return [String]
      attr_reader :version

      # @return [Hash<String, Shape>]
      attr_reader :shapes

      # @return [Shape]
      def service
        @service ||= begin
          _id, service = shapes.find { |_key, shape| shape.type == 'service' }
          service
        end
      end

      # @return Hash<String, Shape>
      def operations
        @operations ||= parse_operations
      end

      private

      # TODO: this could be more efficient by parsing service, resources, and operations in one pass
      def parse_shapes(shapes)
        shapes.each_with_object({}) do |(id, shape), h|
          h[id] = Shape.new(id, shape)
        end
      end

      def parse_operations
        operations = {}
        parse_service_operations(service, operations)
        parse_service_resources(service, operations)
        operations.sort_by { |k, _v| k }.to_h
      end

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
