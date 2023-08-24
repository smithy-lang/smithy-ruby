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

      def retryable?
        (modeled_retryable? ||
          throttling? ||
          transient? ||
          server?) &&
          @http_response.body.respond_to?(:truncate)
      end

      def error_type
        if transient?
          'Transient'
        elsif throttling?
          'Throttling'
        elsif server?
          'ServerError'
        elsif client?
          'ClientError'
        else
          'Unknown'
        end
      end

      def hints
        hints = {}
        if (retry_after = retry_after_hint)
          hints[:retry_after] = retry_after
        end
        hints
      end

      private

      def transient?
        @error.is_a?(Hearth::HTTP::NetworkingError)
      end

      def throttling?
        @http_response.status == 429 || modeled_throttling?
      end

      def server?
        (500..599).cover?(@http_response.status)
      end

      def client?
        (400..499).cover?(@http_response.status)
      end

      def modeled_retryable?
        @error.is_a?(Hearth::ApiError) && @error.retryable?
      end

      def modeled_throttling?
        modeled_retryable? && @error.throttling?
      end

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
