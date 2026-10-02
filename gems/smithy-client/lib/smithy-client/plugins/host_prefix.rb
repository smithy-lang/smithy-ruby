# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class HostPrefix < Plugin
        option(
          :disable_host_prefix_injection,
          default: false,
          doc_type: 'Boolean',
          docstring: 'When `true`, the SDK will not prepend the modeled host prefix to the endpoint.'
        ) do |_config|
          value = ENV['DISABLE_HOST_PREFIX_INJECTION'] || 'false'
          Util.str_to_bool(value)
        end

        def after_initialize(client)
          validate_disable_host_prefix_injection(client.config)
        end

        def validate_disable_host_prefix_injection(config)
          return if [true, false].include?(config.disable_host_prefix_injection)

          raise ArgumentError,
                ':disable_host_prefix_injection must be either `true` or `false`'
        end

        def add_handlers(handlers, config)
          handlers.add(Handler, priority: 25) unless config.disable_host_prefix_injection
        end

        # @api private
        class Handler < Smithy::Client::Handler
          def call(context)
            plan = Schema::Extension.endpoint_host_prefix_plan(context.operation)
            apply_host_prefix(context, plan) if plan
            @handler.call(context)
          end

          private

          def apply_host_prefix(context, plan)
            prefix = +''
            plan.each do |part|
              value = part.is_a?(Symbol) ? label_value(part, context.params) : part
              prefix << value
            end
            context.http_request.endpoint.host = prefix << context.http_request.endpoint.host
          end

          def label_value(name, params)
            raise ArgumentError, "params[:#{name}] must not be nil or blank" if params[name].nil? || params[name].empty?

            params[name]
          end
        end
      end
    end
  end
end
