# frozen_string_literal: true

module Smithy
  module Client
    # The transport contract: sends a request and pushes the response into a
    # caller-supplied sink. This is the swap point exposed as the +:transport+
    # client option (see {Plugins::Transport}); {NetHTTP::Transport} is the
    # built-in HTTP/1.1 implementation. A transport is any object answering
    # {REQUIRED_METHODS} (it need not include this module); conformance can be
    # exercised with the shared compliance tests
    # (+spec/support/transport_contract.rb+).
    #
    # ## Response shaping is the transport's job
    #
    # The transport owns the response lifecycle and PUSHES it into the sink (see
    # {ResponseSink}) rather than returning a pull-stream for the caller to walk.
    # It calls the sink's methods in order:
    #
    # * +sink.headers(status, headers)+ once, first;
    # * +sink.data(chunk)+ zero or more times, in order;
    # * exactly one terminal: +sink.done+ (success) or +sink.error(e)+ (failure).
    #
    # An ABORTED exchange is the one exception: it delivers NO terminal. Once an
    # abort is recorded the transport stops calling the sink entirely, so a
    # cancelled exchange ends silently and the party that called +abort+ is the
    # only one that knows it ended. A caller must not wait on a terminal to
    # observe cancellation.
    #
    # Networking failures are surfaced as +sink.error(NetworkingError)+, not
    # raised. An invalid HTTP method is the exception: it raises {ArgumentError}
    # synchronously (before opening a connection or spawning background work, and
    # without touching the sink), since it is a caller error, not a transport
    # failure.
    #
    # ## Two send methods, one per operation mode
    #
    # The operation mode - not the wire protocol - decides which method the SDK
    # calls. Both take a +request+ ({Http::Request}) and a +sink+ (see above):
    #
    # * +#transmit(request, sink)+ serves a NON-EVENT-STREAM operation (plain
    #   request/response and byte streaming). It DRIVES the response into the sink
    #   to its terminal SYNCHRONOUSLY, then returns nothing. There is no handle to
    #   abort: the exchange has completed by the time it returns, and the
    #   transport owns teardown (releasing or discarding the connection itself).
    #
    # * +#transmit_background(request, sink)+ serves an EVENT-STREAM operation
    #   (output-only or bidirectional). It starts the exchange CONCURRENTLY - the
    #   transport owns the concurrency mechanism (a background thread for
    #   {NetHTTP::Transport}, an async task for an async transport) - and returns
    #   a {Stream} handle IMMEDIATELY, before the response arrives. The sink is
    #   fed asynchronously as inbound events arrive; the event stream layer
    #   consumes them, writes outbound via the handle (for bidirectional streams),
    #   and owns the handle's lifetime and teardown.
    #
    # (INPUT-ONLY streams - client-streaming with a unary response - are out of
    # scope for this contract and not served by either method.)
    #
    # ## Serving only one mode
    #
    # {REQUIRED_METHODS} lists both methods. A transport that serves only one
    # mode implements both and raises {NotSupportedError} from the mode it does
    # not serve, mirroring {Stream#write}/{Stream#close_write} on a transport
    # that cannot do bidirectional streaming.
    #
    # A transport MAY own connection management and protocol-specific concerns
    # (pooling, concurrency mechanism, truncation detection); these are not part
    # of the contract.
    module Transport
      # The messages every transport must answer to be a conforming +:transport+
      # (checked by {Plugins::Transport}). Both modes are required; a transport
      # may opt out of one by raising {NotSupportedError} from it.
      #
      # TODO: fail fast in the event stream layer when an event-stream op hits a
      # transport whose +#transmit_background+ raises {NotSupportedError}.
      REQUIRED_METHODS = %i[transmit transmit_background].freeze
    end
  end
end
