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

        context.logger.debug("Invoking #{i.class.name}##{hook}")
        i.send(hook, i_ctx)
        context.logger.debug("Completed #{i.class.name}##{hook}")
      rescue StandardError => e
        log_last_error(last_error, context)
        last_error = e
        break unless aggregate_errors
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

      def log_last_error(last_error, context)
        context.logger.error(last_error) if last_error
      end

      def log_last_output_error(last_error, context, output)
        return unless last_error && output

        context.logger.error(output.error) if output.error
      end
    end
  end
end
