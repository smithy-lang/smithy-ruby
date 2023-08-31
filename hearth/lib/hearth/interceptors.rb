# frozen_string_literal: true

module Hearth
  # @api private
  module Interceptors
    READ_BEFORE_EXECUTION = :read_before_execution
    MODIFY_BEFORE_SERIALIZATION = :modify_before_serialization
    READ_BEFORE_SERIALIZATION = :read_before_serialization
    READ_AFTER_SERIALIZATION = :read_after_serialization
    MODIFY_BEFORE_RETRY_LOOP = :modify_before_retry_loop
    READ_BEFORE_ATTEMPT = :read_before_attempt
    MODIFY_BEFORE_ATTEMPT_COMPLETION = :modify_before_attempt_completion
    READ_AFTER_ATTEMPT = :read_after_attempt
    MODIFY_BEFORE_SIGNING = :modify_before_signing
    READ_BEFORE_SIGNING = :read_before_signing
    READ_AFTER_SIGNING = :read_after_signing
    MODIFY_BEFORE_TRANSMIT = :modify_before_transmit
    READ_BEFORE_TRANSMIT = :read_before_transmit
    READ_AFTER_TRANSMIT = :read_after_transmit
    MODIFY_BEFORE_DESERIALIZATION = :modify_before_deserialization
    READ_BEFORE_DESERIALIZATION = :read_before_deserialization
    READ_AFTER_DESERIALIZATION = :read_after_deserialization
    MODIFY_BEFORE_COMPLETION = :modify_before_completion
    READ_AFTER_EXECUTION = :read_after_execution

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
        context.logger.debug("Invoking #{i.class.name}##{hook}")
        i.send(hook, i_ctx)
        context.logger.debug("Completed #{i.class.name}##{hook}")
      rescue StandardError => e
        context.logger.error(last_error) if last_error
        last_error = e
        break unless aggregate_errors
      end

      log_last_error(last_error, context, output)
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

      def log_last_error(last_error, context, output)
        return unless last_error && output

        context.logger.error(output.error) if output.error
      end
    end
  end
end
