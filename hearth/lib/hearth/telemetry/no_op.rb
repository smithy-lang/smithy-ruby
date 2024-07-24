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
      def tracer(name = nil)
        @tracer ||= NoOpTracer.new
      end
    end

    # No-op implementation for Tracer
    class NoOpTracer
      def start_span(name, with_parent: nil, attributes: nil, kind: nil)
        NoOpSpan.new
      end

      def in_span(name, attributes: nil, kind: nil)
        yield NoOpSpan.new
      end
    end

    # No-op implementation for Span
    class NoOpSpan
      def set_attribute(key, value)
        self
      end
      alias []= set_attribute

      def add_attributes(attributes)
        self
      end

      def add_event(name, attributes: nil)
        self
      end

      def status=(status); end

      def finish(end_timestamp: nil)
        self
      end

      def record_exception(exception, attributes: nil); end
    end
    # rubocop:enable Lint/UnusedMethodArgument

    # No-op implementation for ContextManager
    class NoOpContextManager
      def current; end
      def current_span; end
      def attach(context); end
      def detach(token); end
    end
  end
end
