# frozen_string_literal: true

module Hearth
  module Retry
    # @api private
    class ErrorInspector
      def initialize(error, http_status)
        @error = error
        @http_status = http_status
      end

      def retryable?
        modeled_retryable? ||
          throttling? ||
          networking? ||
          server?
      end

      def error_type
        if networking?
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

      private

      def throttling?
        @http_status == 429 || modeled_throttling?
      end

      def networking?
        @error.is_a?(Hearth::HTTP::NetworkingError)
      end

      def server?
        (500..599).cover?(@http_status)
      end

      def client?
        (400..499).cover?(@http_status)
      end

      def modeled_retryable?
        @error.is_a?(Hearth::ApiError) && @error.retryable?
      end

      def modeled_throttling?
        @error.is_a?(Hearth::ApiError) && @error.throttling?
      end
    end
  end
end
