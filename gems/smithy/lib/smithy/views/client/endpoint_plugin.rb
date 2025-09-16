# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class EndpointPlugin < View
        def initialize(plan)
          @plan = plan
          @model = plan.model
          _, service = @plan.service.first
          @parameters = build_parameters(service['traits']['smithy.rules#endpointRuleSet'])
          super()
        end

        attr_reader :plan, :parameters

        def module_name
          @plan.module_name
        end

        def endpoint_auth_scheme_bindings
          @plan.welds.map(&:endpoint_auth_scheme_bindings).reduce({}, :merge)
        end

        private

        def build_parameters(endpoint_rules)
          endpoint_rules['parameters'].map { |id, data| EndpointParameter.new(id, data, @plan) }
        end
      end
    end
  end
end
