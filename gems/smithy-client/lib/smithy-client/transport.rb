# frozen_string_literal: true

module Smithy
  module Client
    # The transport contract: sends a request and returns a {Stream} the handler
    # stack consumes. This is the swap point exposed as the +:transport+ client
    # option (see {Plugins::Transport}); {NetHTTP::Transport} is the built-in
    # HTTP/1.1 implementation.
    #
    # A transport is any object that answers {REQUIRED_METHODS}; it need not
    # include this module. The module documents the contract and defines the
    # compatibility surface used to validate a caller-supplied transport.
    # Conformance can be exercised with the shared compliance tests
    # (+spec/support/transport_contract.rb+).
    #
    # ## Contract
    #
    # A transport MUST:
    #
    # * expose +#transmit+, accepting an {Http::Request} and returning an object
    #   satisfying the {Stream} contract;
    # * send the request before returning, so the stream's
    #   {Stream#response_headers} are available without further caller input;
    # * return before the body is consumed (body delivery is pull-based, via
    #   {Stream#each_chunk});
    # * raise {NetworkingError} for networking failures while sending or reading
    #   headers, and {ArgumentError} for a malformed request (e.g. an invalid
    #   HTTP method) without opening a connection.
    #
    # A transport MAY own connection management and protocol-specific concerns
    # (pooling, blocking strategy, truncation detection); these are not part of
    # the contract.
    #
    # ## Required methods
    #
    # +#transmit(request)+
    # * +request+ [{Http::Request}] the request to send.
    # * Returns an object satisfying the {Stream} contract, with its response
    #   status and headers already available (for request/response operations);
    #   the body is read later, on the caller's thread, via {Stream#each_chunk}.
    # * Raises {ArgumentError} if the request has an invalid HTTP method (without
    #   opening a connection).
    # * Raises {NetworkingError} if a networking error occurs while sending the
    #   request or reading the response headers.
    module Transport
      # The messages every transport must answer. This is the compatibility
      # surface checked for a caller-supplied +:transport+.
      REQUIRED_METHODS = %i[transmit].freeze
    end
  end
end
