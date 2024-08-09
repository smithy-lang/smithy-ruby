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

module Hearth
  # Module for EventStreams.
  module EventStream
    class MessageDecodeError < StandardError; end

    class MessageEncodeError < StandardError; end
  end
end
