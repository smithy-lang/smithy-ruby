# frozen_string_literal: true

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
  # A telemetry provider is used to emit telemetry data. By default, the
  # `NoOpTelemetryProvider` will not record or emit any telemetry data.
  # The SDK currently supports OpenTelemetry (OTel) as a provider. To use
  # this provider, require the `opentelemetry-sdk` gem and then, pass in
  # an instance of a `Hearth::Telemetry::OTelProvider` for telemetry
  # provider in the client config.
  #
  # # Configure an OpenTelemetry-based telemetry provider
  # Below example uses the OpenTelemetry-based provider that we support:
  #
  #     require 'opentelemetry-sdk'
  #
  #     # sets up the OpenTelemetry SDK with their config defaults
  #     OpenTelemetry::SDK.configure
  #
  #     otel_provider = Hearth::Telemetry::OTelProvider.new
  #     client = Service::Client.new(telemetry_provider: otel_provider)
  #
  # OpenTelemetry supports many ways to export your telemetry data.
  # See {https://opentelemetry.io/docs/languages/ruby/exporters/ here} for
  # more information.
  #
  # To demonstrate, we could choose to export through the console:
  #
  #     require 'opentelemetry-sdk'
  #
  #     ENV['OTEL_TRACES_EXPORTER'] ||= 'console'
  #
  #     # configures the OpenTelemetry SDK with defaults
  #     OpenTelemetry::SDK.configure
  #
  #     otel_provider = Hearth::Telemetry::OTelProvider.new
  #     client = Service::Client.new(telemetry_provider: otel_provider)
  #
  # If a provider isn't supported, you can implement your own support by
  # following the telemetry interfaces defined in RBS.
  module Telemetry
    # @api private
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
