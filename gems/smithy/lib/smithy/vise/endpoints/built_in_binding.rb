# frozen_string_literal: true

module Smithy
  module Vise
    module Endpoints
      # Endpoint BuiltInBinding
      class BuiltInBinding
        def initialize(id:, render_config:, render_build:, render_test_set:)
          @id = id
          @render_config = render_config
          @render_build = render_build
          @render_test_set = render_test_set
        end

        attr_reader :id

        def render_config(plan)
          @render_config.call(plan)
        end

        def render_build(plan, operation)
          @render_build.call(plan, operation)
        end

        def render_test_set(plan, operation, node)
          @render_test_set.call(plan, operation, node)
        end
      end
    end
  end
end
