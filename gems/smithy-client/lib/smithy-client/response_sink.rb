# frozen_string_literal: true

module Smithy
  module Client
    # Adapts an {Http::Response} to the sink side of the {Transport} contract:
    # it forwards the sink calls (+#headers+/+#data+/+#done+/+#error+) onto the
    # response's push-based +signal_*+ methods, so the transport never needs to
    # know about {Http::Response} directly. See {Transport} for the calling
    # order and terminal guarantees.
    # @api private
    class ResponseSink
      # @param [Http::Response] response
      def initialize(response)
        @response = response
      end

      # @param [Integer] status_code
      # @param [Hash<String, String>] headers
      # @return [void]
      def headers(status_code, headers)
        @response.signal_headers(status_code, headers)
      end

      # @param [String] chunk
      # @return [void]
      def data(chunk)
        @response.signal_data(chunk)
      end

      # Signals successful completion of the response. Terminal.
      # @return [void]
      def done
        @response.signal_done
      end

      # Signals that the exchange failed. Terminal, in place of {#done}.
      # @param [Exception] error The failure cause (a {NetworkingError} for a
      #   transport networking failure, or an {ArgumentError} for an invalid
      #   request; any error terminal is permitted).
      # @return [void]
      def error(error)
        @response.signal_error(error)
      end
    end
  end
end
