# frozen_string_literal: true

module Smithy
  module Client
    # Receives response events from a transport and forwards them to {Http::Response}.
    # Transports call +headers+, +data+, +done+, and +error+ on this adapter
    # instead of the response's +signal_*+ methods.
    # See {Transport} for the expected event order and completion rules.
    # @api private
    class ResponseSink
      # @param [Http::Response] response
      def initialize(response)
        @response = response
      end

      # @param [Integer] status_code
      # @param [Hash<String, String>] headers
      def headers(status_code, headers)
        @response.signal_headers(status_code, headers)
      end

      # @param [String] chunk
      def data(chunk)
        @response.signal_data(chunk)
      end

      # Marks response delivery complete.
      # Repeated calls do nothing.
      def done
        @response.signal_done
      end

      # Records the first failure, even if response delivery already completed.
      # Does not repeat completion or cleanup.
      # @param [StandardError] error Network failures use {NetworkingError};
      #   other failures retain their original exception.
      def error(error)
        @response.signal_error(error)
      end
    end
  end
end
