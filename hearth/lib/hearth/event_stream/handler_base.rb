# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    # Base class for code generated event stream handlers.
    class HandlerBase
      def initialize
        @handlers = Hash.new { |h, k| h[k] = [] }
        @error_handlers = []
        @raw_event_handlers = []
        @headers_handlers = []
      end

      # Called for event stream errors, including:
      #   * Errors raised from event handlers.
      #   * Modeled error events.
      #   * Generic, un-modeled error events.
      def on_error(&block)
        @error_handlers << block
      end

      # Called when headers are received.
      def on_headers(&block)
        @headers_handlers << block
      end

      # Called for every event received with the raw event message.
      def on_raw_event(&block)
        @raw_event_handlers << block
      end

      def emit_headers(headers)
        @headers = headers
        @headers_handlers.each do |handler|
          handler.call(headers)
        end
      end

      def emit(message)
        emit_raw_event(message)

        message_type = message.headers.delete(':message-type')&.value
        case message_type
        when 'error'
          parse_and_emit_error_event(message)
        when 'exception'
          parse_and_emit_exception(message)
        else
          # either type "event" or no type
          parse_and_emit_event(message)
        end
      rescue StandardError => e
        emit_error(e)
      end

      def emit_error(error)
        @error_handlers.each do |handler|
          handler.call(error)
        end
      end

      private

      def emit_raw_event(message)
        @raw_event_handlers.each do |handler|
          handler.call(message)
        end
      end

      def parse_and_emit_error_event(message)
        error = parse_error_event(message)
        emit_error(error)
      end

      def parse_and_emit_exception(message)
        type = message.headers.delete(':exception-type')&.value
        event = parse_event(type, message)
        emit_event(event.class, event)
      end

      def on(type, callback)
        @handlers[type] << callback
      end

      def parse_and_emit_event(message)
        type = message.headers.delete(':event-type')&.value
        event = parse_event(type, message)
        emit_event(event.class, event)
      end

      def emit_event(type, event)
        @handlers[type].each do |handler|
          handler.call(event)
        end
      end
    end
  end
end
