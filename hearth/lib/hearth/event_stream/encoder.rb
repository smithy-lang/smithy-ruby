# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    class Encoder
      # TODO:
      # Set as the body on the request - input events written to body
      # which sends to stream.
      # Uses the MessageBuilder classes.  Must be configured with
      # a signer (and must maintain signer state).
      # This will be the body on the request.
      # It will handle initial request body (if required by protocol).
      # Also allows the H2 Client to set the open stream on it.
    end
  end
end
