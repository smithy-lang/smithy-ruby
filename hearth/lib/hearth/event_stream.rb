# frozen_string_literal: true

require_relative 'event_stream/decoder'
require_relative 'event_stream/encoder'
require_relative 'event_stream/header_value'
require_relative 'event_stream/message'
require_relative 'event_stream/binary/types'
require_relative 'event_stream/binary/message_decoder'
require_relative 'event_stream/binary/message_encoder'

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

    # Raise when insufficient bytes of a message is received
    class IncompleteMessageError < RuntimeError
      def initialize(*_args)
        super('Not enough bytes for event message')
      end
    end

    class PreludeChecksumError < RuntimeError
      def initialize(*_args)
        super('Prelude checksum mismatch')
      end
    end

    class MessageChecksumError < RuntimeError
      def initialize(*_args)
        super('Message checksum mismatch')
      end
    end

    class EventPayloadLengthExceedError < RuntimeError
      def initialize(*_args)
        super('Payload length of a message should be under 16mb.')
      end
    end

    class EventHeadersLengthExceedError < RuntimeError
      def initialize(*_args)
        super('Encoded headers length of a message should be under 128kb.')
      end
    end
  end
end
