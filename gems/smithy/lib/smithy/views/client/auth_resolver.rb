# frozen_string_literal: true

require 'stringio'

module Smithy
  module Views
    module Client
      # @api private
      class AuthResolver < View
        def initialize(plan)
          @plan = plan
          _, @service = plan.service.first
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
            service_auth_schemes.each do |auth_scheme|
              lines << "options << #{render_auth_option(auth_scheme)}"
            end
          else
            lines << "case params.operation_name\n"
            auth_operations.each do |id, operation|
              operation_name = Model::Shape.name(id).underscore
              lines << "when :#{operation_name}\n"
              operation_auth_schemes(operation).each do |auth_scheme|
                lines << "  options << #{render_auth_option(auth_scheme)}"
              end
            end
            lines << 'else'
            service_auth_schemes.each do |auth_scheme|
              lines << "  options << #{render_auth_option(auth_scheme)}"
            end
            lines << 'end'
          end
          lines << 'options'
          lines
        end

        private

        def auth_schemes(welds)
          welds
            .map(&:auth_schemes)
            .reduce({}, :merge)
            .sort_by { |k, _| k }
            .to_h
        end

        def service_has_auth_trait?
          @service.fetch('traits', {}).include?('smithy.api#auth')
        end

        def service_auth_schemes
          service_traits = @service.fetch('traits', {})
          auth_schemes = []
          if service_has_auth_trait?
            service_auth = service_traits.fetch('smithy.api#auth', [])
            add_auth_scheme_from_auth_trait(auth_schemes, service_auth)
          else
            add_registered_auth_schemes(auth_schemes, service_traits)
          end
          auth_schemes << { scheme_id: 'smithy.api#noAuth' } if auth_schemes.empty?
          auth_schemes
        end

        def operations_with_auth_traits
          @operations.select do |_, operation|
            operation_auth?(operation) || optional_operation_auth?(operation)
          end
        end

        def operation_auth?(operation)
          operation.fetch('traits', {}).include?('smithy.api#auth')
        end

        def optional_operation_auth?(operation)
          operation.fetch('traits', {}).include?('smithy.api#optionalAuth')
        end

        def operation_auth_schemes(operation)
          operation_traits = operation.fetch('traits', {})
          auth_schemes = []
          if operation_auth?(operation)
            operation_auth = operation_traits.fetch('smithy.api#auth', [])
            add_auth_scheme_from_auth_trait(auth_schemes, operation_auth)
          else
            add_registered_auth_schemes(auth_schemes, operation_traits)
          end
          if operation_traits.include?('smithy.api#optionalAuth')
            auth_schemes << { scheme_id: 'smithy.api#optionalAuth' }
          end
          auth_schemes << { scheme_id: 'smithy.api#noAuth' } if auth_schemes.empty?
          auth_schemes
        end

        def add_auth_scheme_from_auth_trait(auth_schemes, auth_trait)
          auth_trait.each do |auth_scheme|
            auth_schemes << { scheme_id: auth_scheme } if @auth_schemes.key?(auth_scheme)
          end
        end

        def add_registered_auth_schemes(auth_schemes, traits)
          @auth_schemes.each_key do |k|
            auth_schemes << { scheme_id: k } if traits.include?(k)
          end
        end

        def render_auth_option(auth_scheme)
          "Smithy::Client::AuthOption.new(**#{auth_scheme})"
        end
      end
    end
  end
end
