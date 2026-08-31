# frozen_string_literal: true

module Smithy
  module Client
    # The stream contract: the live handle returned by {Transport#transmit} and
    # consumed by {SendHandler}. {NetHTTP::Stream} is the built-in HTTP/1.1
    # implementation. Documents the required methods and their behavior;
    # subclassing is optional. Validate conformance with the shared compliance
    # tests (+spec/support/stream_contract.rb+).
    #
    # ## Staged, pull-based model
    #
    # Adapter-independent but contract-shaping: an implementation must present
    # its work as these ordered stages, however it fetches data internally.
    #
    # 1. **Headers.** After {Transport#transmit} returns, {#response_headers}
    #    yields the status and headers without further input from the caller.
    # 2. **Body.** The caller pulls the body in order via {#each_chunk} until it
    #    is complete or the stream is aborted.
    # 3. **Terminal.** Iteration ends once: normally, or by surfacing a
    #    {NetworkingError}.
    #
    # A live handle also supports {#abort} for cancellation, and
    # {#write}/{#close_write} for transports that allow post-transmit writes
    # (others raise {NotSupportedError}).
    #
    # ## Concurrency
    #
    # {#each_chunk} runs on the caller's thread. {#abort} MAY be called from
    # another thread; implementations must make the abort/completion transition
    # race-safe and must not deliver chunks after an abort.
    # @api private
    class Stream
      # @return [Array(Integer, Hash<String,String>)] The response status code
      #   and headers.
      def response_headers
        raise NotImplementedError, "#{self.class} must implement #response_headers"
      end

      # Yields raw response body chunks in order on the caller's thread until the
      # body is complete or the stream is aborted.
      # @yieldparam [String] _chunk
      # @raise [NetworkingError] If a networking error occurs while reading, or
      #   the body ends before its advertised length.
      # @return [void]
      def each_chunk
        raise NotImplementedError, "#{self.class} must implement #each_chunk"
      end

      # Writes bytes to the request after transmit. Only for transports that
      # allow post-transmit writes; others raise {NotSupportedError}.
      # @param [String] _bytes
      # @raise [NotSupportedError]
      # @return [void]
      def write(_bytes)
        raise NotSupportedError, "#{self.class} does not support #write"
      end

      # Signals the end of the request body for a writable stream. Only for
      # transports that allow post-transmit writes; others raise
      # {NotSupportedError}.
      # @raise [NotSupportedError]
      # @return [void]
      def close_write
        raise NotSupportedError, "#{self.class} does not support #close_write"
      end

      # Aborts the stream, cancelling the in-progress exchange and releasing the
      # underlying resource without returning it for reuse. Must be safe to call
      # from a thread other than the one driving {#each_chunk}, idempotent, and
      # must never raise (it runs on teardown paths).
      # @param [StandardError, nil] _error
      # @return [void]
      def abort(_error = nil)
        raise NotImplementedError, "#{self.class} must implement #abort"
      end
    end
  end
end
