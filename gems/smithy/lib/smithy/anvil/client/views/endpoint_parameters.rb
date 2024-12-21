# frozen_string_literal: true

module Smithy
  module Anvil
    module Client
      module Views
        # @api private
        class EndpointParameters < View
          def initialize(plan)
            @plan = plan
            @model = plan.model
            @endpoint_rules = Vise::ServiceIndex.new(@model).service.values.first['traits']['smithy.rules#endpointRuleSet']
            @parameters = @endpoint_rules['parameters']
                          .map { |id, data| EndpointParameter.new(id, data, @plan) }

            super()
          end

          attr_reader :parameters

          def namespace
            Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
          end

          def documentation
            '# TODO: Documentation'
          end
        end
      end
    end
  end
end
