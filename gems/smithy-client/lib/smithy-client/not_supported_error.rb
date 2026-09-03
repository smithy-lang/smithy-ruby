# frozen_string_literal: true

module Smithy
  module Client
    # Raised when an operation is not supported by a transport or its stream.
    # Part of the shared stream contract (a peer of {NetworkingError}), not
    # specific to any one adapter: a transport whose stream cannot satisfy a
    # contract method raises this rather than defining its own error.
    #
    # For example, an HTTP/1.1 stream cannot be written to after the request has
    # been transmitted, so {NetHTTP::Stream#write} and
    # {NetHTTP::Stream#close_write} raise this error.
    class NotSupportedError < StandardError; end
  end
end
