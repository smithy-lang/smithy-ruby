# frozen_string_literal: true

module Smithy
  module Client
    # The +Stream+ contract: the control handle returned by
    # {Transport#transmit_background} for an EVENT-STREAM operation (it is the
    # only path that produces a handle - a non-event-stream operation is driven
    # to completion inside {Transport#transmit}, which returns nothing).
    # {NetHTTP::Stream} is the built-in HTTP/1.1 implementation.
    #
    # Inbound response data does not flow back through the +Stream+: the transport
    # pushes it into the sink supplied at {Transport#transmit_background} (see
    # {ResponseSink}) as events arrive on the transport's own concurrency
    # mechanism. The +Stream+ is the OUTBOUND + CONTROL side only - it cancels the
    # exchange (+#abort+) and, for bidirectional-capable transports, writes
    # request-side bytes after transmit (+#write+/+#close_write+).
    #
    # A +Stream+ answers {REQUIRED_FOR_OUTPUT_EVENT_STREAM_OPS} for an output-only
    # event stream and, to also serve a BIDIRECTIONAL one, the write side in
    # {REQUIRED_FOR_BIDI_EVENT_STREAM_OPS}. It need not include this module;
    # conformance can be exercised with the shared compliance tests
    # (+spec/support/stream_contract.rb+).
    #
    # ## Concurrency
    #
    # The exchange runs on the transport's concurrency mechanism, so +#abort+ MAY
    # be called from a thread other than the one driving the exchange.
    # Implementations must make the abort/completion transition race-safe and must
    # not deliver to the sink after an abort. +#abort+ must also be idempotent and
    # never raise, since it runs on teardown paths.
    #
    # ## Methods required for output-only event streams -
    #    {REQUIRED_FOR_OUTPUT_EVENT_STREAM_OPS}
    #
    # +#abort(error = nil)+
    # * Cancels the in-progress exchange and releases the underlying resource
    #   without returning it for reuse. +error+ [{StandardError}, nil] optional
    #   cause. Cross-thread-safe, idempotent, never raises (see Concurrency).
    #   Returns +void+.
    #
    # ## Methods required for bidirectional event streams -
    #    {REQUIRED_FOR_BIDI_EVENT_STREAM_OPS}
    #
    # In addition to +#abort+, a bidirectional stream answers the outbound write
    # side. Both raise {NotSupportedError} on a transport that supports
    # output-only but not bidirectional (e.g. HTTP/1.1):
    #
    # * +#write(bytes)+ - writes +bytes+ (String) to the request after transmit
    #   (outbound events).
    # * +#close_write+ - signals the end of the request body (outbound).
    module Stream
      # Methods sufficient for an OUTPUT-ONLY event stream (server streams,
      # client already sent its single request): cancellation only.
      REQUIRED_FOR_OUTPUT_EVENT_STREAM_OPS = %i[abort].freeze

      # Methods sufficient for a BIDIRECTIONAL event stream: cancellation plus the
      # outbound write side. The event stream layer checks for these and fails
      # fast when a bidirectional operation is invoked against a transport that
      # cannot serve it.
      REQUIRED_FOR_BIDI_EVENT_STREAM_OPS = %i[abort write close_write].freeze
    end
  end
end
