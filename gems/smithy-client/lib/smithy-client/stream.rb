# frozen_string_literal: true

module Smithy
  module Client
    # The stream contract: the live handle returned by {Transport#transmit} and
    # consumed by {SendHandler}. {NetHTTP::Stream} is the built-in HTTP/1.1
    # implementation.
    #
    # This class documents the required methods and their contractual behavior;
    # subclassing is optional. Implementations are expected to conform to this
    # contract, and can validate conformance with the shared stream compliance
    # tests (see +spec/smithy-client/stream_contract.rb+).
    #
    # ## Staged, pull-based model
    #
    # The stream exposes a specific lifecycle that {SendHandler} depends on. It
    # is adapter-independent (not tied to Net::HTTP) but contract-shaping: an
    # implementation must present its work as these ordered stages, regardless
    # of how it fetches data internally.
    #
    # 1. **Headers phase.** After {Transport#transmit} returns,
    #    {#response_headers} yields the response status and headers without
    #    further input from the caller.
    # 2. **Body phase.** The caller then pulls the body in order via
    #    {#each_chunk}, which yields raw chunks until the body is complete or the
    #    stream is aborted.
    # 3. **Terminal.** Iteration ends once, either normally (body complete) or by
    #    surfacing a {NetworkingError}; after that the stream is finished.
    #
    # A live handle also supports {#abort} for cancellation during the exchange,
    # and {#write}/{#close_write} for transports that support writing to a
    # request after transmit (e.g. bidirectional streams). Transports that do
    # not support post-transmit writes raise {NotSupportedError} from those
    # methods.
    #
    # ## Concurrency
    #
    # {#each_chunk} runs on the caller's thread. {#abort} MAY be called from a
    # different thread to cancel an in-progress exchange; implementations must
    # make the abort/completion transition safe against that race and must not
    # deliver chunks after an abort.
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

      # Writes bytes to the request after transmit. Only meaningful for
      # transports supporting post-transmit writes (e.g. bidirectional streams);
      # others raise {NotSupportedError}.
      # @param [String] _bytes
      # @raise [NotSupportedError]
      # @return [void]
      def write(_bytes)
        raise NotSupportedError, "#{self.class} does not support #write"
      end

      # Signals the end of the request body for a writable stream. Only
      # meaningful for transports supporting post-transmit writes; others raise
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
