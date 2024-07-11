# frozen_string_literal: true

module Hearth
  module Telemetry
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
