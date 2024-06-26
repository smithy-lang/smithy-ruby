# frozen_string_literal: true

require_relative 'telemetry/telemetry_provider'
require_relative 'telemetry/span_kind'
require_relative 'telemetry/span_status'

module Hearth
  module Telemetry
    class NoOpProvider < TelemetryProvider
      def initialize
        super(
          tracer_provider: NoOpTracerProvider.new,
          context_manager: NoOpContextManager.new
        )
      end
    end

    class NoOpTracerProvider
      def tracer(name = nil)
        @tracer ||= NoOpTracer.new
      end
    end

    class NoOpTracer
      def in_span(name, attributes: nil, links: nil, start_timestamp: nil, kind: nil)
        yield NoOpSpan.new
      end
    end

    class NoOpSpan
      def set_attribute(key, value)
        self
      end
      alias []= set_attribute

      def add_event(name, attributes: nil)
        self
      end

      def status=(status); end

      def finish(end_timestamp: nil)
        self
      end
    end

    class NoOpContextManager
        def current; end
        def current_span; end
        def attach(context); end
        def detach(token); end
    end
  end
end

