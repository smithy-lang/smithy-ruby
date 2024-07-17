# frozen_string_literal: true

require_relative 'telemetry/context_manager'
require_relative 'telemetry/telemetry_provider'
require_relative 'telemetry/span_kind'
require_relative 'telemetry/span_status'
require_relative 'telemetry/no_op'
require_relative 'telemetry/otel'


module Hearth
  # # Telemetry
  # Observability is the extent to which a system's current state can be
  # inferred from the data it emits. The data emitted is commonly referred
  # as telemetry. The AWS SDK for Ruby currently supports traces as
  # a telemetry signal.
  #
  # A telemetry provider is used to emit telemetry data. By default, this
  # functionality is disabled. The SDK currently supports OpenTelemetry (OTel)
  # as a provider. To use the OTel provider, load the `opentelemetry-sdk` gem
  # and then, pass in an instance of a `Hearth::Telemetry::OTelProvider`
  # for telemetry provider.
  #
  # # Configure a telemetry provider
  # Below example uses the OTel-based provider that we support:
  #
  #     require 'opentelemetry-sdk'
  #     otel_provider = Hearth::Telemetry::OTelProvider.new
  #     client = Service::Client.new(telemetry_provider: otel_provider)
  #
  # If a provider isn't supported, you can implement your own support by following
  # the no-op interfaces within `Hearth::Telemetry`.
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
