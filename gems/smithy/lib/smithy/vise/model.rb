# frozen_string_literal: true

module Smithy
  module Vise
    # Represents a Smithy model.
    class Model
      # @api private
      RESOURCE_LIFECYCLE_KEYS = %w[create put read update delete list]
      # @api private
      RESOURCE_OPERATION_KEYS = %w[operation collectionOperations]
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
        service.shape['operations']&.collect do |shape|
          id = shape['target']
          operations[id] = @shapes[id]
        end
        service.shape['resources']&.collect do |shape|
          id = shape['target']
          parse_resource(@shapes[id], operations)
        end
        Hash[operations.sort_by { |k, _v| k }]
      end

      def parse_resource(resource, operations)
        RESOURCE_LIFECYCLE_KEYS.each do |key|
          next unless resource.shape.key?(key)

          id = resource.shape[key]['target']
          operations[id] = @shapes[id]
        end

        RESOURCE_OPERATION_KEYS.each do |key|
          resource.shape[key]&.collect do |shape|
            id = shape['target']
            operations[id] = @shapes[id]
          end
        end

        resource.shape[RESOURCES_KEY]&.collect do |shape|
          id = shape['target']
          parse_resource(@shapes[id], operations)
        end
      end
    end
  end
end
