# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class AuthPlugin < View
        def initialize(plan)
          @plan = plan
          @auth_schemes = weld_auth_schemes(plan.welds)
          super()
        end

        def module_name
          @plan.module_name
        end

        def auth_schemes
          @auth_schemes.transform_values { |v| v[:auth_scheme_config_option] }
        end

        private

        def weld_auth_schemes(welds)
          weld_auth_schemes = welds.map(&:add_auth_schemes).reduce({}, :merge)
          weld_auth_schemes.except(*welds.map(&:remove_auth_schemes).reduce([], :+))
        end
      end
    end
  end
end
