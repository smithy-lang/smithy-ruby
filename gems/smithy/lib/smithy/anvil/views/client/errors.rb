# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      module Client
        # @api private
        class Errors < View
          def initialize(plan)
            @plan = plan
            @model = plan.model
            super()
          end

          def namespace
            Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
          end

          def errors
            @model
              .shapes
              .select { |_key, shape| shape.traits.any? { |_id, trait| trait.id == 'smithy.api#error' } }
              .map { |id, structure| Error.new(id, structure) }
          end

          # @api private
          class Error
            def initialize(id, structure)
              @id = id
              @structure = structure
            end

            def documentation
              '# TODO!'
            end

            def name
              @structure.name
            end

            def member_names
              @structure
                .shape['members']
                .keys
                .map { |key| Tools::Underscore.underscore(key) }
            end
          end
        end
      end
    end
  end
end
