# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class Gemspec < View
        def initialize(plan)
          @plan = plan
          super()
        end

        def gem_name
          @plan.gem_name
        end

        def dependencies
          dependencies =
            if @plan.type == :schema
              { 'smithy-schema' => '1.0.0.pre1' }
            else
              { 'smithy-client' => '1.0.0.pre1' }
            end
          dependencies = dependencies.merge(@plan.welds.map(&:add_dependencies).reduce({}, :merge))
          dependencies = dependencies.except(*@plan.welds.map(&:remove_dependencies).reduce([], :+))
          dependencies.sort
        end
      end
    end
  end
end
