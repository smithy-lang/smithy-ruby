# frozen_string_literal: true

module Hearth
  module Telemetry
    # OpenTelemetry-based TelemetryProvider
    class OTelProvider < TelemetryProvider
      def initialize
        unless Hearth::Telemetry.otel_loaded?
          raise ArgumentError,
                'Requires the `opentelemetry-sdk` gem to use OTel Provider.'
        end
        super(
          tracer_provider: OpenTelemetry.tracer_provider,
          context_manager: OTelContextManager.new
        )
      end
    end

    # OpenTelemetry-based ContextManager
    class OTelContextManager < ContextManager
      # Returns current context
      #
      # @return [Context]
      def current
        OpenTelemetry::Context.current
      end

      # Returns the current span from current context
      #
      # @return Span
      def current_span
        OpenTelemetry::Trace.current_span
      end

      # Associates a Context with the caller’s current execution unit.
      # Returns a token to be used with the matching call to detach.
      #
      # @param [Context] context The new context
      # @return [Object] token A token to be used when detaching
      def attach(context)
        OpenTelemetry::Context.attach(context)
      end

      # Restore the previous Context associated with the current
      # execution unit to the value it had before attaching a
      # specified Context.
      #
      # @param [Object] token The token provided by matching the call to attach
      # @return [Boolean] True if the calls matched, False otherwise
      def detach(token)
        OpenTelemetry::Context.detach(token)
      end
    end
  end
end
