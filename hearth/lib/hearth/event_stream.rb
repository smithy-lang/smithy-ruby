# frozen_string_literal: true

require_relative 'event_stream/async_output'
require_relative 'event_stream/decoder'
require_relative 'event_stream/encoder'
require_relative 'event_stream/handler_base'
require_relative 'event_stream/header_value'
require_relative 'event_stream/message'
require_relative 'event_stream/binary/types'
require_relative 'event_stream/binary/message_decoder'
require_relative 'event_stream/binary/message_encoder'

require_relative 'event_stream/middleware/handlers'
require_relative 'event_stream/middleware/sign'

module Hearth
  # Module for EventStreams.
  module EventStream
    # Raised when reading bytes exceed buffer total bytes
    class ReadBytesExceedLengthError < RuntimeError
      def initialize(target_byte, total_len)
        msg = "Attempting reading bytes to offset #{target_byte} exceeds " \
              "buffer length of #{total_len}"
        super(msg)
      end
    end

    # Raised when insufficient bytes of a message is received
    class IncompleteMessageError < RuntimeError
      def initialize(*_args)
        super('Not enough bytes for event message')
      end
    end

    # Raised when there is a prelude checksum mismatch.
    class PreludeChecksumError < RuntimeError
      def initialize(*_args)
        super('Prelude checksum mismatch')
      end
    end

    # Raised when there is a message checksum mismatch.
    class MessageChecksumError < RuntimeError
      def initialize(*_args)
        super('Message checksum mismatch')
      end
    end

    # Raised when an event payload exceeds the maximum allowed length.
    class EventPayloadLengthExceedError < RuntimeError
      def initialize(*_args)
        super('Payload length of a message should be under 16mb.')
      end
    end

    # Raised when event headers exceed maximum allowed length.
    class EventHeadersLengthExceedError < RuntimeError
      def initialize(*_args)
        super('Encoded headers length of a message should be under 128kb.')
      end
    end

    # Raised when event streams parsers encounter are unable to parse a message.
    class EventStreamParserError < RuntimeError
    end
  end
end
