# frozen_string_literal: true

module Hearth
  module Telemetry
    # Type of span.
    # Can be used to describe relationships between spans in a trace.
    module SpanKind
      # Default. Represents an internal operation within an application.
      INTERNAL = :internal

      # Represents handling synchronous network requests.
      SERVER = :server

      # Represents a request to some remote service.
      CLIENT = :client

      # Represents a child of an asynchronous +PRODUCER+ request.
      CONSUMER = :consumer

      # Represents an asynchronous request.
      PRODUCER = :producer
    end
  end
end
