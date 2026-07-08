# frozen_string_literal: true

require_relative 'protocol'

module Smithy
  module Client
    # Default protocol used when no protocol is registered for a client. All
    # methods are no-ops, so build/parse handlers can delegate safely without
    # a nil check.
    # @api private
    class NoOpProtocol < Protocol
      def build_request(_context); end

      def parse_data(_response); end

      def parse_error(_response); end
    end
  end
end
