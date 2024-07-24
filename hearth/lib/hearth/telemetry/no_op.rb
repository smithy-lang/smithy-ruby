# frozen_string_literal: true

module Hearth
  module Telemetry
    # No-op implementation for TelemetryProvider
    class NoOpTelemetryProvider < TelemetryProvider
      def initialize
        super(
          tracer_provider: NoOpTracerProvider.new,
          context_manager: NoOpContextManager.new
        )
      end
    end

    # No-op implementation for TracerProvider
    # rubocop:disable Lint/UnusedMethodArgument
    class NoOpTracerProvider
      # Returns a Tracer instance.
      #
      # @param [optional String] name Tracer name
      # @return [Tracer]
      def tracer(name = nil)
        @tracer ||= NoOpTracer.new
      end
    end

    # No-op implementation for Tracer
    class NoOpTracer
      # Used when a caller wants to manage the activation/deactivation and
      # lifecycle of the Span and its parent manually.
      #
      # @param [String] name Span name
      # @param [optional Context] with_parent Parent Context
      # @param [optional Hash] attributes Attributes to attach to the span
      # @param [optional Hearth::Telemetry::SpanKind] kind Type of Span
      # @return [Span]
      def start_span(name, with_parent: nil, attributes: nil, kind: nil)
        NoOpSpan.new
      end

      # A helper for the default use-case of extending the current trace
      # with a span.
      # On exit, the Span that was active before calling this method will
      # be reactivated. If an exception occurs during the execution of the
      # provided block, it will be recorded on the span and re-raised.
      #
      # @param [String] name Span name
      # @param [optional Hash] attributes Attributes to attach to the span
      # @param [optional Hearth::Telemetry::SpanKind] kind Type of Span
      # @return [Span]
      def in_span(name, attributes: nil, kind: nil)
        yield NoOpSpan.new
      end
    end

    # No-op implementation for Span
    class NoOpSpan
      # Set attribute
      #
      # @param [String] key
      # @param [String, Boolean, Numeric, Array<String, Numeric, Boolean>] value
      #   Value must be non-nil and (array of) string, boolean or numeric type.
      #   Array values must not contain nil elements and all elements must be of
      #   the same basic type (string, numeric, boolean).
      #
      # @return [self] returns itself
      def set_attribute(key, value)
        self
      end
      alias []= set_attribute

      # Add attributes
      #
      # @param [Hash{String => String, Numeric, Boolean, Array<String, Numeric,
      #   Boolean>}] attributes Values must be non-nil and (array of) string,
      #   boolean or numeric type. Array values must not contain nil elements
      #   and all elements must be of the same basic type (string, numeric,
      #   boolean).
      # @return [self] returns itself
      def add_attributes(attributes)
        self
      end

      # Add event to a Span.
      #
      # @param [String] name Name of the event.
      # @param [optional Hash{String => String, Numeric, Boolean, Array<String,
      #   Numeric, Boolean>}] attributes Values must be non-nil and (array of)
      #   string, boolean or numeric type. Array values must not contain nil
      #   elements and all elements must be of the same basic type (string,
      #   numeric, boolean).
      # @return [self] returns itself
      def add_event(name, attributes: nil)
        self
      end

      # Sets the Span status.
      #
      # @param [Hearth::Telemetry::Status] status The new status, which
      #   overrides the default Span status, which is OK.
      # @return [void]
      def status=(status); end

      # Finishes the Span.
      #
      # @param [optional Time] end_timestamp End timestamp for the span.
      # @return [self] returns itself
      def finish(end_timestamp: nil)
        self
      end

      # Record an exception during the execution of this span. Multiple
      # exceptions can be recorded on a span.
      #
      # @param [Exception] exception The exception to be recorded
      # @param [optional Hash{String => String, Numeric, Boolean, Array<String,
      #   Numeric, Boolean>}] attributes One or more key:value pairs, where the
      #   keys must be strings and the values may be (array of) string, boolean
      #   or numeric type.
      # @return [void]
      def record_exception(exception, attributes: nil); end
    end
    # rubocop:enable Lint/UnusedMethodArgument

    # No-op implementation for ContextManager
    class NoOpContextManager
      # Returns current context
      #
      # @return [Context]
      def current; end

      # Returns the current span from current context
      #
      # @return Span
      def current_span; end

      # Associates a Context with the caller’s current execution unit.
      # Returns a token to be used with the matching call to detach.
      #
      # @param [Context] context The new context
      # @return [Object] token A token to be used when detaching
      def attach(context); end

      # Restore the previous Context associated with the current
      # execution unit to the value it had before attaching a
      # specified Context.
      #
      # @param [Object] token The token provided by matching the call to attach
      # @return [Boolean] True if the calls matched, False otherwise
      def detach(token); end
    end
  end
end
