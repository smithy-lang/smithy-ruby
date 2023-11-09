# frozen_string_literal: true

module Hearth
  # @api private
  module Interceptors
    # Invoke all interceptors.
    #
    # @param [Symbol] hook The specific hook to invoke.
    # @param input [Hearth::Structure] input
    # @param [Hearth::Context] context
    # @param [Hearth::Output] output
    # @param [Boolean] aggregate_errors (false) When true, all interceptors are
    #   run and only the last error is returned. When false, returns immediately
    #   if an error is encountered.
    # @return [nil, StandardError] nil if successful, a standard error otherwise
    def self.invoke(hook:, input:, context:, output:, aggregate_errors: false)
      i_ctx = interceptor_context(input, context, output)
      last_error = nil

      context.interceptors.each do |i|
        next unless i.respond_to?(hook)

        log_debug(context, i, "Invoking #{hook}")
        i.send(hook, i_ctx)
        log_debug(context, i, "Finished #{hook}")
      rescue StandardError => e
        log_debug(context, i, "Error in #{hook}: #{e} (#{e.class})")
        log_last_interceptor_error(last_error, i, context)
        last_error = e
        break unless aggregate_errors
      ensure
      end

      log_last_output_error(last_error, context, output)
      last_error
    end

    class << self
      private

      def interceptor_context(input, context, output)
        Hearth::InterceptorContext.new(
          input: input,
          request: context.request,
          response: context.response,
          output: output
        )
      end

      def log_last_interceptor_error(last_error, interceptor, context)
        return unless last_error

        message = "Dropping error: #{last_error} (#{last_error.class})"
        context.logger.error(
          "[#{context.invocation_id}] [#{interceptor.class}] #{message}"
        )
      end

      def log_last_output_error(last_error, context, output)
        return unless last_error && output
        return unless output.error

        message = "Dropping error: #{output.error} (#{output.error.class})"
        context.logger.error(
          "[#{context.invocation_id}] [Interceptors] #{message}"
        )
      end

      def log_debug(context, interceptor, message)
        context.logger.debug(
          "[#{context.invocation_id}] [#{interceptor.class}] #{message}"
        )
      end
    end
  end
end
