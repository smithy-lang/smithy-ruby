# frozen_string_literal: true

# This is generated code!

module Weather
  module Plugins
    # Protocol plugin - allows user to configure protocol on client.
    # TODO: Add convenience mapping - see https://github.com/smithy-lang/smithy-ruby/pull/264/files#r1946524403
    # @api private
    class Protocol < Smithy::Client::Plugin
      option(
        :protocol,
        default: nil,
        doc_type: '#build, #parse, #error',
        rbs_type: 'Smithy::Client::_Protocol',
        docstring: <<~DOCS)
          This configuration is required to build requests and parse responses.
          In Smithy, a protocol is a named set of rules that defines the syntax
          and semantics of how a client and server communicate. The given protocol
          must provide the following functionalities: `build`, `parse` and `error`.
          See existing protocols within Smithy::Client::Protocols for examples.
        DOCS

      # @api private
      class Build < Smithy::Client::Handler
        def call(context)
          context.config.protocol.build(context)
          @handler.call(context)
        end
      end

      # @api private
      class Parse < Smithy::Client::Handler
        def call(context)
          output = @handler.call(context)
          output.data = context.config.protocol.parse(context) unless output.error
          output
        end
      end

      # @api private
      class Error < Smithy::Client::Handler
        def call(context)
          output = @handler.call(context)
          output.error = context.config.protocol.error(context) unless output.error
          output
        end
      end

      def add_handlers(handlers, _config)
        handlers.add(Build)
        handlers.add(Parse)
        handlers.add(Error, step: :sign)
      end
    end
  end
end
