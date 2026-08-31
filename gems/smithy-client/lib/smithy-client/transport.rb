# frozen_string_literal: true

module Smithy
  module Client
    # The transport contract: the object responsible for sending a request and
    # returning a {Stream} the handler stack can consume. This is the documented
    # swap point exposed as the +:transport+ client option (see
    # {Plugins::Transport}); {NetHTTP::Transport} is the built-in HTTP/1.1
    # implementation.
    #
    # A custom transport is any object responding to {#transmit}. This class
    # documents the required method and its contractual behavior; subclassing is
    # optional. Implementations are expected to conform to this contract, and
    # can validate conformance with the shared transport compliance tests (see
    # +spec/smithy-client/transport_contract.rb+).
    #
    # ## Contract
    #
    # A transport MUST:
    #
    # * expose a single {#transmit} method that accepts an {Http::Request} and
    #   returns an object satisfying the {Stream} contract;
    # * send the request (headers and body) before returning, such that the
    #   returned stream's {Stream#response_headers} are available without further
    #   input from the caller (for plain request/response operations);
    # * return before the response body has been consumed - body delivery is
    #   pull-based and driven by the caller through {Stream#each_chunk};
    # * raise {NetworkingError} for transport/networking failures that occur
    #   while sending the request or reading the response headers, and
    #   {ArgumentError} for a malformed request (e.g. an invalid HTTP method)
    #   without opening a connection.
    #
    # A transport MAY own connection management (pooling, keep-alive) and any
    # protocol-specific concerns (blocking strategy, body-truncation detection);
    # these are intentionally not part of the contract.
    # @api private
    class Transport
      # Sends the request and returns a live {Stream}. The stream's response
      # status and headers must be available immediately (for
      # request/response operations); the body is read later, on the caller's
      # thread, via {Stream#each_chunk}.
      # @param [Http::Request] _request
      # @return [Stream]
      # @raise [ArgumentError] If the request has an invalid HTTP method.
      # @raise [NetworkingError] If a networking error occurs while sending the
      #   request or reading the response headers.
      def transmit(_request)
        raise NotImplementedError, "#{self.class} must implement #transmit(request)"
      end
    end
  end
end
