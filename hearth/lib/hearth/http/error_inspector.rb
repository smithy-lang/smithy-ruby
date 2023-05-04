# frozen_string_literal: true

require 'time'

module Hearth
  module HTTP
    # An HTTP error inspector, using hints from status code and headers.
    # @api private
    class ErrorInspector
      def initialize(error, http_response)
        @error = error
        @http_response = http_response
      end

      def transient?
        @error.is_a?(Hearth::HTTP::NetworkingError)
      end

      def throttling?
        @http_response.status == 429
      end

      def server?
        (500..599).cover?(@http_response.status)
      end

      def client?
        (400..499).cover?(@http_response.status)
      end

      def hints
        hints = {}
        hints[:retry_after_hint] = retry_after_hint if retry_after_hint
        hints
      end

      private

      def retry_after_hint
        retry_after = @http_response.headers['retry-after']
        Integer(retry_after)
      rescue ArgumentError # string is present, assume it is a date
        begin
          Time.parse(retry_after) - Time.now
        rescue ArgumentError # empty string, somehow
          nil
        end
      rescue TypeError # header is not prseent
        nil
      end
    end
  end
end
