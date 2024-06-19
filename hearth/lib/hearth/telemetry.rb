# frozen_string_literal: true

module Hearth
  module Telemetry
    # Object that represents an telemetry provider
    class TelemetryProvider
      def initialize(tracer_provider: nil, context_manager: nil)
        @tracer_provider = tracer_provider
        @context_manger = context_manager
      end
      attr_reader :tracer_provider
      attr_reader :context_manager
    end

    class NoOpTelemetryProvider < TelemetryProvider
      def initialize
        super(
          tracer_provider: NoOpTracerProvider.new,
          context_manager: NoOpContextManager.new
        )
      end
    end

    class NoOpTracerProvider
      def tracer(*args)
        @tracer ||= NoOpTracer.new
      end
    end

    class NoOpTracer
      def in_span(*args); end
    end

    class NoOpContextManager
      def current; end
      def current_span; end
      def attach(_context); end
      def detach(_context); end
    end
  end
end

