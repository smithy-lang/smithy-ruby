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
    class ReadBytesExceedLengthError < RuntimeError; end

    # Raised when insufficient bytes of a message is received
    class IncompleteMessageError < RuntimeError; end

    # Raised when there is a prelude checksum mismatch.
    class PreludeChecksumError < RuntimeError; end

    # Raised when there is a message checksum mismatch.
    class MessageChecksumError < RuntimeError; end

    # Raised when an event payload exceeds the maximum allowed length.
    class EventPayloadLengthExceedError < RuntimeError; end

    # Raised when event headers exceed maximum allowed length.
    class EventHeadersLengthExceedError < RuntimeError; end

    # Raised when event streams parsers encounter are unable to parse a message.
    class EventStreamParserError < RuntimeError; end
  end
end
