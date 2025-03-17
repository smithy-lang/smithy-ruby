# frozen_string_literal: true

module Smithy
  module Client
    module Plugins
      # @api private
      class Protocol < Plugin
        option(
          :protocol,
          doc_default: '<DEFAULT_PROTOCOL>',
          doc_type: 'String, Class',
          docstring: 'The protocol to use for request serialization and response deserialization.'
        )

        def add_handlers(handlers, config)
          return unless config.protocol

          handlers.add(BuildHandler)
          handlers.add(ParseHandler, step: :parse)
        end

        def before_initialize(client_class, options)
          protocol = options[:protocol]

          case protocol
          when nil
            protocol_class = client_class.protocols.values.first
            options[:protocol] = protocol_class.new if protocol_class
          when String
            protocol_class = client_class.protocols[protocol]
            raise ArgumentError, "Unknown protocol: #{protocol}" unless protocol_class

            options[:protocol] = protocol_class.new
          else
            options[:protocol] = protocol
          end
        end
      end

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
          output = @handler.call(context)
          output.error = context.config.protocol.parse_error(context) unless output.error
          output.data = context.config.protocol.parse_data(context) unless output.error
          output
        end
      end
    end
  end
end
