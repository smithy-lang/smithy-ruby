# frozen_string_literal: true

require 'logger'

module Smithy
  module Client
    module Plugins
      # @api private
      class Logging < Plugin
        option(
          :logger,
          default: nil,
          doc_type: Logger,
          docstring: <<~DOCS)
            The Logger instance to send log messages to. If this option is not set,
            logging is disabled.
          DOCS

        option(
          :log_level,
          default: :info,
          doc_type: Symbol,
          docstring: 'The log level to send messages to the logger at.'
        )

        def add_handlers(handlers, config)
          handlers.add(Handler, step: :validate) if config.logger
        end

        # @api private
        class Handler < Client::Handler
          # @param[HandlerContext] context
          # @return [Output]
          def call(context)
            context[:logging_started_at] = Time.now
            output = @handler.call(context)
            context[:logging_completed_at] = Time.now
            log(context.config, output)
            output
          end

          private

          # @param [Configuration] config
          # @param [Output] output
          # @return [void]
          def log(config, output)
            config.logger.send(config.log_level, output)
          end
        end
      end
    end
  end
end
