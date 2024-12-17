# frozen_string_literal: true

module Smithy
  module Anvil
    module Views
      module Client
        # @api private
        class EndpointParameters < View
          def initialize(plan)
            @plan = plan
            @model = plan.model
            @endpoint_rules = @model.service.traits['smithy.rules#endpointRuleSet']
            super()
          end

          def namespace
            Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
          end

          def documentation
            "# TODO: Documentation"
          end

          def parameters
            @parameters ||= @endpoint_rules.data['parameters']
              .map { |id, data| EndpointParameter.new(id, data, @plan) }
          end
        end
      end
    end
  end
end
