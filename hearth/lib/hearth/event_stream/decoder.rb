# frozen_string_literal: true

module Hearth
  module EventStream
    class Decoder
      def initialize(message_decoder:, event_handler:)
        @message_decoder = message_decoder
        @event_handler = event_handler
        @events = []
        @headers = nil
      end

      attr_reader :events
      attr_reader :headers

      def headers=(headers)
        @headers = headers
        @event_handler.emit_headers(headers)
      end

      def write(chunk)
        loop do
          message, empty = @message_decoder.decode(chunk)
          chunk = nil
          if message
            @events << message
            @event_handler.emit(message)
          end
          break if empty
        end
      end
    end
  end
end
