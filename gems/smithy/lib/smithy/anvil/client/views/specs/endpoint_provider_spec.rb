# frozen_string_literal: true

module Smithy
  module Anvil
    module Client
      module Views
        module Specs
          # @api private
          class EndpointProviderSpec < View
            def initialize(plan)
              @plan = plan
              @model = plan.model
              @endpoint_rules = @model.service.traits['smithy.rules#endpointRuleSet']
              @endpoint_tests = @model.service.traits['smithy.rules#endpointTests']

              @parameters = @endpoint_rules
                            .data['parameters']
                            .map { |id, data| EndpointParameter.new(id, data, @plan) }

              @test_cases = @endpoint_tests
                            .data['testCases']
                            .map { |data| EndpointTestCase.new(data, @plan) }
              super()
            end

            attr_reader :parameters, :test_cases

            def namespace
              Tools::Namespace.namespace_from_gem_name(@plan.options[:gem_name])
            end

            def documentation
              '# TODO: Documentation'
            end

            # @api private
            class EndpointTestCase
              def initialize(data, plan)
                @data = data
                @plan = plan

                @documentation = data['documentation']
                @expect = data['expect']
                @operation_inputs = data['operationInputs']
                @params = data['params']&.transform_keys do |key|
                  key.underscore.to_sym
                end
                @params ||= {}
              end

              attr_reader :expect, :documentation, :params, :expect, :operation_inputs

              def expect_error?
                !@expect['error'].nil?
              end
            end
          end
        end
      end
    end
  end
end
