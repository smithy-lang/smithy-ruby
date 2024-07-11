# frozen_string_literal: true

require_relative 'telemetry/context_manager'
require_relative 'telemetry/telemetry_provider'
require_relative 'telemetry/span_kind'
require_relative 'telemetry/span_status'

module Hearth
  # Observability support
  module Telemetry
    # @return true if opentelemetry-sdk is available
    def self.otel_loaded?
      if @use_otel.nil?
        @use_otel =
          begin
            require 'opentelemetry-sdk'
            true
          rescue LoadError, NameError
            false
          end
      end
      @use_otel
    end

    # No-op implementation for Telemetry Provider
    class NoOpTelemetryProvider < TelemetryProvider
      def initialize
        super(
          tracer_provider: NoOpTracerProvider.new,
          context_manager: NoOpContextManager.new
        )
      end
    end

    # No-op implementation for Tracer Provider
    class NoOpTracerProvider
      def tracer(name = nil)
        @tracer ||= NoOpTracer.new
      end
    end

    # No-op implementation for Tracer
    class NoOpTracer
      def in_span(
        name,
        attributes: nil,
        links: nil,
        start_timestamp: nil,
        kind: nil
      )
        yield NoOpSpan.new
      end
    end

    # No-op implementation for Span
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

    # No-op implementation for ContextManager
    class NoOpContextManager < ContextManager; end

    # OpenTelemetry-based Telemetry Provider
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

    # OpenTelemetry-based Context Manager
    class OTelContextManager < ContextManager
      def current
        OpenTelemetry::Context.current
      end

      def current_span
        OpenTelemetry::Trace.current_span
      end

      def attach(context)
        OpenTelemetry::Context.attach(context)
      end

      def detach(token)
        OpenTelemetry::Context.detach(token)
      end
    end
  end
end
