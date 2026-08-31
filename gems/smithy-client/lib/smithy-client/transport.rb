# frozen_string_literal: true

module Smithy
  module Client
    # The transport contract: sends a request and returns a {Stream} the handler
    # stack consumes. This is the swap point exposed as the +:transport+ client
    # option (see {Plugins::Transport}); {NetHTTP::Transport} is the built-in
    # HTTP/1.1 implementation. A custom transport is any object responding to
    # {#transmit}. Documents the required method and its behavior; subclassing is
    # optional. Validate conformance with the shared compliance tests
    # (+spec/support/transport_contract.rb+).
    #
    # ## Contract
    #
    # A transport MUST:
    #
    # * expose {#transmit}, accepting an {Http::Request} and returning an object
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
