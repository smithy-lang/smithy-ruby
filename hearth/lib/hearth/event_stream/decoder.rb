# frozen_string_literal: true

module Hearth
  module EventStream
    class Decoder
      def initialize(message_decoder:, event_handler:)
        @message_decoder = message_decoder
        @event_handler = event_handler
        @events = []
      end

      attr_reader :events

      def write(chunk)
        puts "Decoder received chunk of data, processing into messages"
        loop do
          message, empty = @message_decoder.decode(chunk)
          if message
            puts "Got a message (in the decoder).  Calling event handler."
            @events << message
            @event_handler.emit_event(message)
          end
          break if empty
        end
      end
    end
  end
end
