# frozen_string_literal: true

module Smithy
  module Client
    # The stream contract: the live handle returned by {Transport#transmit} and
    # consumed by {SendHandler}. {NetHTTP::Stream} is the built-in HTTP/1.1
    # implementation.
    #
    # A stream is any object that answers {REQUIRED_METHODS}; it need not include
    # this module. The module documents the contract and defines the
    # compatibility surface. Conformance can be exercised with the shared
    # compliance tests (+spec/support/stream_contract.rb+).
    #
    # ## Staged, pull-based model
    #
    # Adapter-independent but contract-shaping: an implementation must present
    # its work as these ordered stages, however it fetches data internally.
    #
    # 1. **Headers.** After {Transport#transmit} returns, +#response_headers+
    #    yields the status and headers without further input from the caller.
    # 2. **Body.** The caller pulls the body in order via +#each_chunk+ until it
    #    is complete or the stream is aborted.
    # 3. **Terminal.** Iteration ends once: normally, or by surfacing a
    #    {NetworkingError}.
    #
    # A live handle also supports +#abort+ for cancellation, and
    # +#write+/+#close_write+ for transports that allow post-transmit writes
    # (others raise {NotSupportedError}).
    #
    # ## Concurrency
    #
    # +#each_chunk+ runs on the caller's thread. +#abort+ MAY be called from
    # another thread; implementations must make the abort/completion transition
    # race-safe and must not deliver chunks after an abort.
    #
    # ## Required methods
    #
    # +#response_headers+
    # * Returns +[Integer, Hash<String,String>]+ - the response status code and
    #   headers. Available immediately after the transport returns the stream.
    #
    # +#each_chunk { |chunk| ... }+
    # * Yields raw response body chunks (String) in order, on the caller's
    #   thread, until the body is complete or the stream is aborted.
    # * Raises {NetworkingError} on a networking error while reading, or if the
    #   body ends before its advertised length.
    # * Returns +void+.
    #
    # +#write(bytes)+
    # * Writes +bytes+ (String) to the request after transmit. Only for
    #   transports that allow post-transmit writes; others raise
    #   {NotSupportedError}.
    #
    # +#close_write+
    # * Signals the end of the request body for a writable stream. Only for
    #   transports that allow post-transmit writes; others raise
    #   {NotSupportedError}.
    #
    # +#abort(error = nil)+
    # * Cancels the in-progress exchange and releases the underlying resource
    #   without returning it for reuse. +error+ [{StandardError}, nil] optional
    #   cause. Must be safe to call from a thread other than the one driving
    #   +#each_chunk+, idempotent, and must never raise (it runs on teardown
    #   paths). Returns +void+.
    module Stream
      # The messages every stream must answer. +#write+ and +#close_write+ are
      # part of the surface but may raise {NotSupportedError} for transports that
      # do not allow post-transmit writes.
      REQUIRED_METHODS = %i[response_headers each_chunk write close_write abort].freeze
    end
  end
end
