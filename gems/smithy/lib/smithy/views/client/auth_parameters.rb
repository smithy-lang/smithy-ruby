# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class AuthParameters < View
        def initialize(plan)
          @plan = plan
          super()
        end

        def module_name
          @plan.module_name
        end

        def parameters
          [AuthParameter.new(name: :operation_name, documentation: 'The name of the operation.')]
        end
      end
    end
  end
end
