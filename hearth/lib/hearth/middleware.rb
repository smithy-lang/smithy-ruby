# frozen_string_literal: true

module Hearth
  # @api private
  module Middleware
    # Helper methods for logging to middleware.
    module Logging
      # Logs a debug message to the logger on context. The message is prefixed
      # with the invocation id and the class name.
      def log_debug(context, message)
        context.config.logger.debug(
          "[#{context.invocation_id}] [#{self.class}] #{message}"
        )
      end
    end
  end
end

require_relative 'middleware/auth'
require_relative 'middleware/build'
require_relative 'middleware/endpoint'
require_relative 'middleware/host_prefix'
require_relative 'middleware/parse'
require_relative 'middleware/retry'
require_relative 'middleware/send'
require_relative 'middleware/sign'
require_relative 'middleware/validate'
require_relative 'middleware/initialize'
