# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      class Gemspec < View
        def initialize(plan)
          @plan = plan
        end

        def gem_name
          @plan.options[:gem_name]
        end

        def gem_version
          @plan.options[:gem_version]
        end
      end
    end
  end
end
