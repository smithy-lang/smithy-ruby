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
            host_prefix = Schema::Extension.endpoint_host_prefix(context.operation)
            apply_host_prefix(context, host_prefix) if host_prefix
            @handler.call(context)
          end

          private

          # TODO: optimize this to collect all labels in one pass
          def apply_host_prefix(context, host_prefix)
            host_labels = Schema::Extension.host_label_index(context.operation.input)
            prefix = host_prefix.gsub(/\{.+?}/) do |label|
              label_value(host_labels, label.delete('{}'), context.params)
            end
            context.http_request.endpoint.host = prefix + context.http_request.endpoint.host
          end

          def label_value(host_labels, label, params)
            name = host_labels[label]
            raise ArgumentError, "#{label} is not a valid host label" if name.nil?
            raise ArgumentError, "params[:#{name}] must not be nil or blank" if params[name].nil? || params[name].empty?

            params[name]
          end
        end
      end
    end
  end
end
