# frozen_string_literal: true

require 'net/https'

module Smithy
  module Client
    # Raised when a networking error occurs.
    class NetworkingError < StandardError
      NETWORK_ERRORS = [
        SocketError, EOFError, IOError, Timeout::Error,
        Errno::ECONNABORTED, Errno::ECONNRESET, Errno::EPIPE, Errno::EINVAL,
        Errno::ETIMEDOUT, Errno::EHOSTUNREACH, Errno::ECONNREFUSED,
        OpenSSL::SSL::SSLError, OpenSSL::SSL::SSLErrorWaitReadable,
        Net::HTTPFatalError
      ].freeze
      private_constant :NETWORK_ERRORS

      # Wraps recognized network error types from transport and response processing.
      # Other errors, including an existing NetworkingError, are returned unchanged.
      # @param [StandardError] error
      # @return [StandardError]
      # @api private
      def self.wrap(error)
        NETWORK_ERRORS.any? { |type| error.is_a?(type) } ? new(error) : error
      end

      # @param [StandardError] error
      def initialize(error)
        super(error.message)
        @original_error = error
      end

      attr_reader :original_error
    end
  end
end
