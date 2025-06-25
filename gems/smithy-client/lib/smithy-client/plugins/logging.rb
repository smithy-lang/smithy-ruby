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
          docstring: 'The Logger instance to send log messages to. If this option is not set, logging is disabled.'
        )

        option(
          :log_level,
          default: :info,
          doc_type: Symbol,
          docstring: 'The log level to send messages to the logger at.'
        )

        option(
          :log_formatter,
          doc_type: 'Smithy::Client::LogFormatter',
          doc_default: 'Aws::Log::Formatter.default',
          docstring: 'The log formatter used by the logger.'
        ) do |config|
          LogFormatter.default if config.logger
        end

        def add_handlers(handlers, config)
          handlers.add(Handler, step: :validate) if config.logger
        end

        # @api private
        class Handler < Client::Handler
          def call(context)
            context[:logging_started_at] = Time.now
            response = @handler.call(context)
            context[:logging_completed_at] = Time.now
            log(context.config, response)
            response
          end

          private

          def log(config, response)
            config.logger.send(config.log_level, config.log_formatter.format(response))
          end
        end
      end
    end
  end
end
