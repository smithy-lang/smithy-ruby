# frozen_string_literal: true

module Hearth
  module Telemetry
    # TODO
    class TelemetryProvider
      def initialize(tracer_provider: nil, context_manager: nil)
        @tracer_provider = tracer_provider
        @context_manger = context_manager
      end
      attr_reader :tracer_provider
      attr_reader :context_manager
    end
  end
end
