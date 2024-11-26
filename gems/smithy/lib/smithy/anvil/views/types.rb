# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      class Types < View
        def initialize(plan)
          @plan = plan
          @model = plan.model
        end

        attr_reader :plan

        def namespace
          Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
        end

        def types
          @model
            .shapes
            .select { |_key, shape| shape.type == 'structure' }
            .reject { |_key, shape| shape.traits.any? { |_id, trait| trait.name == 'error' } }
            .map { |_key, structure| structure.name }
        end
      end
    end
  end
end
