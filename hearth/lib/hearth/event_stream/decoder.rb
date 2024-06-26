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
    end
  end
end
