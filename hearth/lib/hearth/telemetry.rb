# frozen_string_literal: true

module Hearth
  module Telemetry
    # Object that represents an telemetry provider
    class TelemetryProvider
      def initialize(tracer_provider: nil, context_manager: nil)
        @tracer_provider = tracer_provider
        @context_manger = context_manager
      end
      attr_reader :tracer_provider
      attr_reader :context_manager
    end

    class ContextManager
      class << self
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

    class NoOpTelemetryProvider < TelemetryProvider
      def initialize
        super(
          tracer_provider: NoOpTracerProvider.new,
          context_manager: NoOpContextManager.new
        )
      end
    end

    class NoOpTracerProvider
      def tracer(name = nil)
        @tracer ||= NoOpTracer.new
      end
    end

    class NoOpTracer
      def in_span(name, attributes: nil, links: nil, start_timestamp: nil, kind: nil)
        yield NoOpSpan.new
      end
    end

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

    class NoOpContextManager < ContextManager
      class << self
        def current; end
        def current_span; end
        def attach(context); end
        def detach(token); end
      end
    end

    class TraceSpanStatus
      class << self
        private :new

        def unset(description = '')
          new(UNSET, description: description)
        end

        def ok(description = '')
          new(OK, description: description)
        end

        def error(description = '')
          new(ERROR, description: description)
        end
      end

        def initialize(code, description: '')
          @code = code
          @description = description
        end

        attr_reader :code, :description

        OK = 0
        UNSET = 1
        ERROR = 2
    end

    module SpanKind
      # Internal, Client, Server, Producer and Consumer
      INTERNAL = :internal
      SERVER = :server
      CLIENT = :client
      CONSUMER = :consumer
      PRODUCER = :producer
    end

  end
end

