# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      module Types
        # @api private
        class Gemspec < View
          def initialize(plan)
            @plan = plan
            super()
          end

          def gem_name
            "#{@plan.options[:gem_name]}-types"
          end

          def gem_version
            @plan.options[:gem_version]
          end
        end
      end
    end
  end
end
