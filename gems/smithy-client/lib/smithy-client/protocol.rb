# frozen_string_literal: true

module Smithy
  module Client
    # Base class documenting the protocol interface. A protocol serializes
    # requests and deserializes responses for a specific wire format.
    #
    # A custom protocol passed via +Client.new(protocol:)+ is any object that
    # responds to these methods; it need not inherit from this class.
    # @api private
    class Protocol
      # Serialize the request into the wire format.
      # @param [Interceptor::Context] _context
      def build_request(_context)
        raise NotImplementedError
      end

      # Deserialize a successful response body.
      # @param [Response] _response
      def parse_data(_response)
        raise NotImplementedError
      end

      # Deserialize an error response into the modeled error.
      # @param [Response] _response
      def parse_error(_response)
        raise NotImplementedError
      end
    end
  end
end
