# frozen_string_literal: true

require_relative 'interceptor/context'
require_relative 'interceptor/hooks'

module Hearth
  # Module for Interceptors - a generic extension point that allows injecting
  # logic at specific stages of execution within the SDK. Logic injection is
  # done with hooks that the interceptor implements.
  #
  # Hooks are either read-only or read/write.
  # Read-only hooks allow an interceptor to read the input,
  # transport request, transport response or output messages.
  # Read/write hooks allow an interceptor to modify one of these messages.
  module Interceptor
    # @api private
    # Apply all interceptors that implement the given hook
    # @param [InterceptorList] interceptors the interceptors to apply
    # @param [Symbol] hook the specific hook to apply for
    # @param input operation input
    # @param [Hearth::Context] context
    # @param [Hearth::Output] output may be nil if unavailable
    # @param [Boolean] aggregate_errors if true all interceptors are run and
    #   only the last error is returned.  If false, returns immediately if an
    #   error is encountered.
    # @return nil if successful, an exception otherwise
    def self.apply(interceptors:, hook:, input:, context:, output:,
                   aggregate_errors: false)
      i_ctx = interceptor_context(input, context, output)
      last_error = nil
      interceptors.each do |i|
        next unless i.respond_to?(hook)

        begin
          i.send(hook, i_ctx)
        rescue StandardError => e
          context.logger.error(last_error) if last_error
          last_error = e
          break unless aggregate_errors
        end
      end

      set_output_error(last_error, context, output)

      last_error
    end

    class << self
      private

      def interceptor_context(input, context, output)
        Hearth::Interceptor::Context.new(
          input: input,
          request: context.request,
          response: context.response,
          output: output
        )
      end

      def set_output_error(last_error, context, output)
        return unless last_error && output

        context.logger.error(output.error) if output.error
        output.error = last_error
      end
    end
  end
end
