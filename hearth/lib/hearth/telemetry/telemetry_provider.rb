# frozen_string_literal: true

module Hearth
  module Telemetry
    # Base for all TelemetryProvider classes
    class TelemetryProvider
      def initialize(tracer_provider: nil, context_manager: nil)
        @tracer_provider = tracer_provider
        @context_manager = context_manager
      end
      attr_reader :tracer_provider, :context_manager
    end
  end
end
