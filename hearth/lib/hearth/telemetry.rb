# frozen_string_literal: true

require_relative 'telemetry/base'
require_relative 'telemetry/span_kind'
require_relative 'telemetry/span_status'
require_relative 'telemetry/no_op'
require_relative 'telemetry/otel'

module Hearth
  # Observability is the extent to which a system's current state can be
  # inferred from the data it emits. The data emitted is commonly referred
  # as Telemetry. Hearth currently supports traces as a telemetry signal.
  #
  # A telemetry provider is used to emit telemetry data. By default, the
  # +NoOpTelemetryProvider+ will not record or emit any telemetry data.
  # The SDK currently supports OpenTelemetry (OTel) as a provider. See
  # {OTelProvider} for more information.
  #
  # If a provider isn't supported, you can implement your own provider by
  # inheriting the following base classes and implementing the interfaces
  # defined:
  # * {TelemetryProviderBase}
  # * {ContextManagerBase}
  # * {TracerProviderBase}
  # * {TracerBase}
  # * {SpanBase}
  module Telemetry; end
end
