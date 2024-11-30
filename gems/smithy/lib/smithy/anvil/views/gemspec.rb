# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      class Gemspec < View
        def initialize(plan)
          @plan = plan
        end

        def gem_name
          case @plan.type
          when :types
            "#{@plan.options[:gem_name]}-types"
          else
            @plan.options[:gem_name]
          end
        end

        def gem_version
          @plan.options[:gem_version]
        end
      end
    end
  end
end
