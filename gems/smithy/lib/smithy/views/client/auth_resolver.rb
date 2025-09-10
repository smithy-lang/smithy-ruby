# frozen_string_literal: true

module Smithy
  module Views
    module Client
      # @api private
      class AuthResolver < View
        def initialize(plan)
          @plan = plan
          _, service = plan.service.first
          @service_traits = service.fetch('traits', {})
          @operations = Model::ServiceIndex.new(plan.model).operations_for(plan.service)
          @auth_schemes = auth_schemes(plan.welds)
          super()
        end

        def module_name
          @plan.module_name
        end

        def auth_rules_code
          lines = []
          lines << 'options = []'
          auth_operations = operations_with_auth_traits
          if auth_operations.empty?
            add_service_auth_schemes_to_code(lines)
          else
            add_operation_case_to_code(lines, auth_operations)
          end
          lines << 'options'
          lines
        end

        private

        def add_service_auth_schemes_to_code(lines)
          service_auth_schemes.each do |auth_scheme|
            lines << "options << '#{auth_scheme}'"
          end
        end

        def add_operation_case_to_code(lines, auth_operations)
          lines << 'case parameters.operation_name'
          auth_operations.each do |id, operation|
            operation_name = Model::Shape.name(id).underscore
            lines << "when :#{operation_name}"
            add_operation_auth_options_to_code(lines, operation)
          end
          lines << 'else'
          add_service_auth_schemes_to_code(lines)
          lines << 'end'
        end

        def add_operation_auth_options_to_code(lines, operation)
          operation_auth_schemes(operation).each do |auth_scheme|
            lines << "  options << '#{auth_scheme}'"
          end
        end

        def auth_schemes(welds)
          weld_auth_schemes = welds.map(&:add_auth_schemes).reduce([], :+)
          weld_auth_schemes -= welds.map(&:remove_auth_schemes).reduce([], :+)
          weld_auth_schemes.sort
        end

        def service_has_auth_trait?
          @service_traits.key?('smithy.api#auth')
        end

        def service_auth_schemes
          auth_schemes = []
          if service_has_auth_trait?
            service_auth = @service_traits.fetch('smithy.api#auth', [])
            add_auth_schemes_from_auth_trait(auth_schemes, service_auth)
          else
            add_registered_auth_schemes(auth_schemes, @service_traits)
          end
          auth_schemes << 'smithy.api#noAuth' if auth_schemes.empty?
          auth_schemes
        end

        def operations_with_auth_traits
          @operations.select do |_, operation|
            operation_auth?(operation) || optional_operation_auth?(operation)
          end
        end

        def operation_auth?(operation)
          operation.fetch('traits', {}).key?('smithy.api#auth')
        end

        def optional_operation_auth?(operation)
          operation.fetch('traits', {}).key?('smithy.api#optionalAuth')
        end

        def operation_auth_schemes(operation)
          operation_traits = operation.fetch('traits', {})
          auth_schemes = build_operation_auth_schemes(operation, operation_traits)
          auth_schemes << 'smithy.api#noAuth' if auth_schemes.empty? || optional_operation_auth?(operation)
          auth_schemes
        end

        def build_operation_auth_schemes(operation, operation_traits)
          auth_schemes = []
          if operation_auth?(operation)
            add_explicit_operation_auth_schemes(auth_schemes, operation_traits)
          elsif !service_has_auth_trait? && !optional_operation_auth?(operation)
            add_registered_auth_schemes(auth_schemes, operation_traits)
          else
            add_service_auth_schemes_for_operation(auth_schemes)
          end
          auth_schemes
        end

        def add_explicit_operation_auth_schemes(auth_schemes, operation_traits)
          operation_auth = operation_traits.fetch('smithy.api#auth', [])
          add_auth_schemes_from_auth_trait(auth_schemes, operation_auth)
        end

        def add_service_auth_schemes_for_operation(auth_schemes)
          service_auth_schemes.each do |auth_scheme|
            auth_schemes << auth_scheme unless auth_scheme == 'smithy.api#noAuth'
          end
        end

        def add_auth_schemes_from_auth_trait(auth_schemes, auth_trait)
          auth_trait.each do |auth_scheme|
            auth_schemes << auth_scheme if @auth_schemes.include?(auth_scheme)
          end
        end

        def add_registered_auth_schemes(auth_schemes, traits)
          @auth_schemes.each do |auth_scheme|
            auth_schemes << auth_scheme if traits.key?(auth_scheme)
          end
        end
      end
    end
  end
end
