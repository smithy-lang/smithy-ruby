# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      module Client
        # @api private
        class ClientClass < View
          def initialize(plan)
            @plan = plan
            @model = plan.model
            super()
          end

          def plugins
            plugins = []
            plugins << 'Smithy::Client::Plugins::NetHTTP' if any_operation_has_http_trait?
            plugins
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
            @model.operations.map { |id, shape| Operation.new(id, shape) }
          end

          private

          def any_operation_has_http_trait?
            @model.operations.any? do |_, operation|
              operation.traits.keys.include?('smithy.api#http')
            end
          end

          # @api private
          class Operation
            def initialize(id, operation)
              @id = id
              @operation = operation
            end

            def documentation
              '# TODO!'
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
