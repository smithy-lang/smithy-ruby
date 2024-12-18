# frozen_string_literal: true

module Smithy
  module Anvil
    module Client
      # @api private
      class Operations
        RESOURCE_LIFECYCLE_KEYS = %w[create put read update delete list].freeze
        RESOURCE_OPERATION_KEYS = %w[operation collectionOperations].freeze
        RESOURCES_KEY = 'resources'

        def initialize(model)
          @model = model
          @service = parse_service
        end

        def operations
          @operations ||= parse_operations
        end

        private

        def parse_service
          _id, service = @model.shapes.find { |_key, shape| shape.type == 'service' }
          service
        end

        def parse_operations
          operations = {}
          parse_service_operations(operations)
          parse_service_resources(operations)
          operations.sort_by { |k, _v| k }.to_h
        end

        def parse_service_operations(operations)
          @service.shape['operations']&.collect do |shape|
            id = shape['target']
            operations[id] = @model.shapes[id]
          end
        end

        def parse_service_resources(operations)
          @service.shape['resources']&.collect do |shape|
            id = shape['target']
            parse_resource(@model.shapes[id], operations)
          end
        end

        def parse_resource(resource, operations)
          parse_lifecycles(resource, operations)
          parse_resource_operations(resource, operations)

          resource.shape[RESOURCES_KEY]&.collect do |shape|
            id = shape['target']
            parse_resource(@model.shapes[id], operations)
          end
        end

        def parse_lifecycles(resource, operations)
          RESOURCE_LIFECYCLE_KEYS.each do |key|
            next unless resource.shape.key?(key)

            id = resource.shape[key]['target']
            operations[id] = @model.shapes[id]
          end
        end

        def parse_resource_operations(resource, operations)
          RESOURCE_OPERATION_KEYS.each do |key|
            resource.shape[key]&.collect do |shape|
              id = shape['target']
              operations[id] = @model.shapes[id]
            end
          end
        end
      end
    end
  end
end
