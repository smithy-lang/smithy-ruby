# frozen_string_literal: true

require_relative '../no_op_protocol'

module Smithy
  module Client
    module Plugins
      # Generic protocol plugin. Resolves the +:protocol+ option and installs
      # build/parse handlers that delegate serialization and deserialization to
      # the resolved protocol instance.
      # @api private
      class Protocol < Plugin
        option(
          :protocol,
          doc_type: 'Symbol, Object',
          docstring: 'The protocol used for request serialization and response ' \
                     'deserialization. Defaults to the service default protocol. ' \
                     'May be a Symbol naming a supported protocol, or a custom ' \
                     'object implementing the protocol interface.'
        )

        # @api private
        class BuildHandler < Handler
          def call(context)
            context.config.protocol.build_request(context)
            @handler.call(context)
          end
        end

        # @api private
        class ParseHandler < Handler
          def call(context)
            response = @handler.call(context)
            response.data = context.config.protocol.parse_data(context) unless response.error
            response
          end
        end

        # @api private
        class ErrorHandler < Handler
          def call(context)
            response = @handler.call(context)
            response.error = context.config.protocol.parse_error(context) if response.error.nil?
            response
          end
        end

        def add_handlers(handlers, _config)
          handlers.add(BuildHandler)
          handlers.add(ParseHandler)
          handlers.add(ErrorHandler, step: :sign)
        end

        # TODO: pass in relevant settings to protocol instance on client init
        def before_initialize(client_class, options)
          case options[:protocol]
          when nil
            options[:protocol] = client_class.protocols.values.first&.new || NoOpProtocol.new
          when Symbol
            options[:protocol] = resolve!(client_class, options[:protocol])
            # else: custom protocol instance, used as-is
          end
        end

        private

        # TODO: client class to have prioritized list
        def resolve!(client_class, name)
          protocol_class = client_class.protocols[name]
          raise ArgumentError, "Unknown protocol: #{name}" unless protocol_class

          protocol_class.new
        end
      end
    end
  end
end
