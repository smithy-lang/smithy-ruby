# frozen_string_literal: true

module Hearth
  module EventStream
    # Event Stream decoder.  Replaces the request body on event stream
    # operations and is responsible for processing chunks of data
    # into decoded messages and calling the event_handler's emit method.
    class Decoder
      # @param [Object] message_decoder a protocol specific message decoder.
      # @param [Hearth::EventStream::HandlerBase] event_handler an event
      #   handler.  The emit method will be called once per decoded message.
      def initialize(message_decoder:, event_handler:)
        @message_decoder = message_decoder
        @event_handler = event_handler
      end

      # Emit headers to the event handler.
      # Called when headers are received on the stream.
      # @param [Hash] headers
      def emit_headers(headers)
        @event_handler.emit_headers(headers)
      end

      # Decode a chunk of data received from the stream into messages.
      # Calls the event_handler's emit method once per decoded message.
      def write(chunk)
        loop do
          message, empty = @message_decoder.decode(chunk)
          chunk = nil
          @event_handler.emit(message) if message
          break if empty
        end
      end
    end
  end
end
