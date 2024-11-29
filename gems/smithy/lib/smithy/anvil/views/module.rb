# frozen_string_literal: true

require 'stringio'

module Smithy
  module Anvil
    module Views
      class Module < View
        def initialize(plan)
          @plan = plan
          @model = plan.model
          @gem_name = plan.options[:gem_name]
        end

        def requires
          case @plan.type
          when :types
            ["#{@gem_name}-types/types"]
          else
            []
          end
        end

        def documentation
          _id, service = @model.shapes.find { |_key, shape| shape.type == 'service' }
          _id, trait = service.traits.find { |_id, trait| trait.id == 'smithy.api#documentation' }
          "# #{trait.data}"
        end

        def namespace
          Tools::Namespace.namespace_from_gem_name(@gem_name)
        end

        def version
          @plan.options[:gem_version]
        end
      end
    end
  end
end
