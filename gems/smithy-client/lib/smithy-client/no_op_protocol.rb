# frozen_string_literal: true

module Smithy
  module Client
    # Default protocol used when no protocol is registered for a client.
    # Also documents the protocol interface: a protocol serializes requests,
    # deserializes responses, and builds stubbed responses for a specific
    # wire format. A custom protocol passed via +Client.new(protocol:)+ is
    # any object that responds to these methods.
    #
    # All methods are no-ops, so handlers and stubbing can delegate safely
    # without a nil check.
    # TODO: move the protocol-interface documentation above into a Developer
    #  Guide ("build your own SDK") once one exists - this class may the wrong
    #  long-term home for it. See PR #349 review discussion.
    # @api private
    class NoOpProtocol
      # Serialize the request into the wire format.
      # @param [HandlerContext] _context
      def build_request(_context); end

      # Deserialize a successful response body.
      # @param [HandlerContext] _context
      # @return [Object, nil] the response data
      def parse_data(_context); end

      # Deserialize an error response into the modeled error. Called on
      # every response; must return nil when the response is not an error.
      # @param [HandlerContext] _context
      # @return [StandardError, nil]
      def parse_error(_context); end

      # Build a stubbed HTTP response for the given output data.
      # @param [Configuration] _config
      # @param [Schema::OperationShape] _operation
      # @param [Object] _data
      # @return [Http::Response]
      def stub_data(_config, _operation, _data)
        Http::Response.new
      end

      # Build a stubbed HTTP error response for the given error code.
      # @param [Configuration] _config
      # @param [String] _error_code
      # @return [Http::Response]
      def stub_error(_config, _error_code)
        Http::Response.new
      end
    end
  end
end
