# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream

    # Base class for code generated event stream handlers.
    class HandlerBase
      def initialize
        @handlers = {}
        @error_handlers = []
        @exception_handlers = []
        @raw_event_handlers = []
        @headers_handlers = []
      end

      # Un-modeled errors.  Message-type error
      def on_error(&block)
        @error_handlers << block
      end

      # Modeled errors with message-type exception
      def on_exception(&block)
        @exception_handlers << block
      end

      def on(type, callback)
        (@handlers[type] ||= []) << callback
      end

      def on_unknown_event(&block)
        on(:unknown, block)
      end

      def on_initial_response(&block)
        on('initial-response', block)
      end

      def on_headers(&block)
        @headers_handlers << block
      end

      # called for every event received with the raw event message
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
        @raw_event_handlers.each do |handler|
          handler.call(message)
        end

        message_type = message.headers.delete(':message-type')&.value
        if message_type
          case message_type
          when 'error'
            emit_error_event(message)
          when 'event'
            parse_and_emit_event(message)
          when 'exception'
            type = message.headers.delete(':exception-type')&.value
            event = parse_event(type, message)
            if event
              emit_exception_event(type, event)
            else
              emit_exception_event(:unknown, message)
            end
          else
            raise EventStreamParserError,
                  "Unrecognized :message-type value for '#{message_type}'"
          end
        else
          # no :message-type header, regular event by default
          parse_and_emit_event(message)
        end
      end

      def parse_and_emit_event(message)
        type = message.headers.delete(':event-type')&.value
        event = parse_event(type, message)
        if event
          emit_event(type, event)
        else
          emit_event(:unknown, message)
        end
      end

      def emit_event(type, event)
        @handlers[type]&.each do |handler|
          handler.call(event)
        end
      end

      def emit_exception_event(type, event)
        emit_event(type, event)
        @exception_handlers.each do |handler|
          handler.call(type, event)
        end
      end

      def emit_error_event(message)
        error_code = message.headers.delete(':error-code')
        error_message = message.headers.delete(':error-message')
        @error_handlers.each do |handler|
          handler.call(error_code&.value, error_message&.value)
        end
      end
    end
  end
end
