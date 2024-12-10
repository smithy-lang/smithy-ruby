# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      module Client
        # @api private
        class ClientClass < View
          RESOURCE_LIFECYCLE_KEYS = %w[create put read update delete list]
          RESOURCE_OPERATION_KEYS = %w[operation collectionOperations]
          RESOURCES_KEY = 'resources'

          def initialize(plan)
            @plan = plan
            @model = plan.model
            super()
          end

          def namespace
            Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
          end

          def gem_name
            @plan.options[:gem_name]
          end

          def gem_version
            @plan.options[:gem_version]
          end

          def operations
            operations = []
            _id, service = @model.shapes.find { |_key, shape| shape.type == 'service' }
            service.shape['operations']&.collect do |shape|
              id = shape['target']
              operations << Operation.new(id, @model.shapes[id])
            end
            service.shape['resources']&.collect do |shape|
              id = shape['target']
              parse_resource(@model.shapes[id], operations)
            end
            operations
          end

          private

          def parse_resource(resource, operations)
            RESOURCE_LIFECYCLE_KEYS.each do |key|
              next unless resource.shape.key?(key)

              id = resource.shape[key]['target']
              operations << Operation.new(id, @model.shapes[id])
            end

            RESOURCE_OPERATION_KEYS.each do |key|
              resource.shape[key]&.collect do |shape|
                id = shape['target']
                operations << Operation.new(id, @model.shapes[id])
              end
            end

            resource.shape[RESOURCES_KEY]&.collect do |shape|
              id = shape['target']
              parse_resource(@model.shapes[id], operations)
            end
          end

          # @api private
          class Operation
            def initialize(id, operation)
              @id = id
              @operation = operation
            end

            def documentation
              "# TODO!"
            end

            def name
              Tools::Underscore.underscore(@operation.name)
            end
          end
        end
      end
    end
  end
end
