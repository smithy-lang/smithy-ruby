# frozen_string_literal: true

module Hearth
  module Telemetry
    # Base for all TelemetryProvider classes
    class TelemetryProvider
      # @param [Class] tracer_provider A provider that returns
      #  a tracer instance.
      # @param [Class] context_manager Manages context and
      #  used to return the current context.
      def initialize(tracer_provider: nil, context_manager: nil)
        @tracer_provider = tracer_provider
        @context_manager = context_manager
      end
      # @return [TracerProvider]
      attr_reader :tracer_provider

      # @return [ContextManager]
      attr_reader :context_manager
    end
  end
end
