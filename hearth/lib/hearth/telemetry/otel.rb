# frozen_string_literal: true

module Hearth
  module Telemetry
    # OTelProvider allows to emit telemetry data based on OpenTelemetry.
    #
    # To use this provider, require the +opentelemetry-sdk+ gem and then,
    # pass in an instance of a +Hearth::Telemetry::OTelProvider+ as the
    # telemetry provider in the client config.
    #
    # @example Configuration
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
    # See {https://opentelemetry.io/docs/languages/ruby/exporters here} for
    # more information.
    #
    # @example Exporting via console
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
    class OTelProvider < TelemetryProviderBase
      def initialize
        unless Hearth::Telemetry.otel_loaded?
          raise ArgumentError,
                'Requires the `opentelemetry-sdk` gem to use OTel Provider.'
        end
        super(
          # tracer_provider: OpenTelemetry.tracer_provider,
          tracer_provider: OTelTracerProvider.new,
          context_manager: OTelContextManager.new
        )
      end
    end

    # rubocop:disable Lint/MissingSuper

    # OpenTelemetry-based Tracer Provider, an entry point for
    # creating Tracer instances.
    class OTelTracerProvider < TracerProviderBase
      def initialize
        @tracer_provider = OpenTelemetry.tracer_provider
      end

      def tracer(name = nil)
        OTelTracer.new(@tracer_provider.tracer(name))
      end
    end

    # OpenTelemetry-based Tracer, responsible for creating spans.
    class OTelTracer < TracerBase
      def initialize(tracer)
        @tracer = tracer
      end

      def start_span(name, with_parent: nil, attributes: nil, kind: nil)
        span = @tracer.start_span(
          name,
          with_parent: with_parent,
          attributes: attributes,
          kind: kind
        )
        OTelSpan.new(span)
      end

      def in_span(name, attributes: nil, kind: nil, &block)
        @tracer.in_span(name, attributes: attributes, kind: kind) do |span|
          wrapped_span = OTelSpan.new(span)
          block.call(wrapped_span)
        end
      end
    end

    # OpenTelemetry-based Span, represents a single operation
    # within a trace.
    class OTelSpan < SpanBase
      def initialize(span)
        @span = span
      end

      # @api private
      attr_reader :span

      def set_attribute(key, value)
        @span.set_attribute(key, value)
      end
      alias []= set_attribute

      def add_attributes(attributes)
        @span.add_attributes(attributes)
      end

      def add_event(name, attributes: nil)
        @span.add_event(name, attributes: attributes)
      end

      def status=(status)
        @span.status = status
      end

      def finish(end_timestamp: nil)
        @span.finish(end_timestamp: end_timestamp)
      end

      def record_exception(exception, attributes: nil)
        @span.record_exception(exception, attributes: attributes)
      end
    end
    # rubocop:enable Lint/MissingSuper

    # OpenTelemetry-based ContextManager, manages context and
    # used to return the current context within a trace.
    class OTelContextManager < ContextManagerBase
      # Returns current context.
      #
      # @return [Context]
      def current
        OpenTelemetry::Context.current
      end

      # Returns the current span from current context.
      #
      # @return Span
      def current_span
        OTelSpan.new(OpenTelemetry::Trace.current_span)
      end

      # Associates a Context with the caller’s current execution unit.
      # Returns a token to be used with the matching call to detach.
      #
      # @param [Context] context The new context
      # @return [Object] token A token to be used when detaching
      def attach(context)
        OpenTelemetry::Context.attach(context)
      end

      # Restore the previous Context associated with the current
      # execution unit to the value it had before attaching a
      # specified Context.
      #
      # @param [Object] token The token provided by matching the call to attach
      # @return [Boolean] True if the calls matched, False otherwise
      def detach(token)
        OpenTelemetry::Context.detach(token)
      end
    end
  end
end
