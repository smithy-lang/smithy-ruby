# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    class HandlerBase

      def initialize
        @handlers = {}
        @error_handlers = []
        @exception_handlers = []
        @raw_event_handlers = []
      end

      attr_accessor :encoder

      def end_input_stream
        # TODO
      end

      # Unmodeled errors.  Message-type error
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
        on(:initial_response, block)
      end

      # called for every event received with the raw event message
      def on_raw_event(&block)
        @raw_event_handlers << block
      end

      def emit_event(message)
        @raw_event_handlers.each do |handler|
          handler.call(message)
        end

        message_type = message.headers.delete(":message-type")
        if message_type
          case message_type.value
          when 'error'
            emit_error_event(message)
          when 'event'
            type = message.headers.delete(":event-type")
            event = parse_event(type, message)
            if event
              emit_event(type, event)
            else
              emit_event(:unknown, message)
            end
          when 'exception'
            type = message.headers.delete(":exception-type")
            event = parse_event(type, message)
            if event
              emit_exception_event(type, event)
            else
              emit_exception_event(:unknown, message)
            end
          else
            raise EventStreamParserError.new(
              "Unrecognized :message-type value for '#{message_type}'")
          end
        else
          # no :message-type header, regular event by default
          parse_and_emit_event(raw_event)
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
        error_code = message.headers.delete(":error-code")
        error_message = message.headers.delete(":error-message")
        @error_handlers.each do |handler|
          handler.call(error_code&.value, error_message&.value)
        end
      end

      def join
        # Wait until output stream is closed
        # TODO
      end

      def kill
        # terminates the output stream (before the service has sent an end stream)
        # TODO
      end

    end
  end
end
