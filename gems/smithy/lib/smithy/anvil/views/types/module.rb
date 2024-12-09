# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      module Types
        # @api private
        class Module < View
          def initialize(plan)
            @plan = plan
            @model = plan.model
            super()
          end

          def gem_name
            "#{@plan.options[:gem_name]}-types"
          end

          def gem_version
            @plan.options[:gem_version]
          end

          def documentation
            _id, service = @model.shapes.find { |_key, shape| shape.type == 'service' }
            _id, trait = service.traits.find { |_id, trait| trait.id == 'smithy.api#documentation' }
            "# #{trait.data}"
          end

          def namespaces
            Tools::Namespace.namespaces_from_gem_name(@plan.options[:gem_name])
          end
        end
      end
    end
  end
end