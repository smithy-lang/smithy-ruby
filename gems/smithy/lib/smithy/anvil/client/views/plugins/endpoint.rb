# frozen_string_literal: true

module Smithy
  module Anvil
    module Client
      module Views
        module Plugins
          # @api private
          class Endpoint < View
            def initialize(plan)
              @plan = plan
              @model = plan.model
              @endpoint_rules = @model.service.traits['smithy.rules#endpointRuleSet']
              super()
            end

            attr_reader :plan

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
end
