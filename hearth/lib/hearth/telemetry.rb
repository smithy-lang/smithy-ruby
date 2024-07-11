# frozen_string_literal: true

require_relative 'telemetry/context_manager'
require_relative 'telemetry/telemetry_provider'
require_relative 'telemetry/span_kind'
require_relative 'telemetry/span_status'
require_relative 'telemetry/no_op'
require_relative 'telemetry/otel'

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
  end
end
