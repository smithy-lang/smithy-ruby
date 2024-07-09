# frozen_string_literal: true

module Hearth
  module EventStream
    # TODO: Set as the body on the Response - IO “like” - has a write method.
    # Stream is setup to write bytes to this.
    # Combines logic from v3 EventStreamDecoder and EventParser.
    # Has a (protocol specific) MessageDecoder.
    # Has a reference to the EventStreamHandler, which it will signal events on.
    #
    class Decoder
      def initialize(message_decoder:, event_handler:)
        @message_decoder = message_decoder
        @event_handler = event_handler
        @events = []
      end

      attr_reader :events

      def write(chunk)
        puts "Decoder recieved chunk of data, processing into messages"
        loop do
          message, empty = @message_decoder.decode(chunk)
          if message
            puts "Got a message (in the decoder).  Calling event handler."
            @events << message
            @event_handler.event(message)
          end
          break if empty
        end
      end
    end
  end
end
