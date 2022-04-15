# frozen_string_literal: true

module Hearth
  module Retry
    # @api private
    class ErrorInspector
      def retryable?(error)
        server?(error) ||
          modeled_retryable?(error) ||
          throttling?(error) ||
          networking?(error)
      end

      def error_type(error)
        if throttling?(error)
          'Throttling'
        elsif networking?(error)
          'Transient'
        elsif server?(error)
          'ServerError'
        elsif (400..499).cover?(error.status_code)
          'ClientError'
        else
          'Unknown'
        end
      end

      private

      def throttling?(error)
        error.status_code == 429 || modeled_throttling?(error)
      end

      def networking?(error)
        error.is_a?(Hearth::HTTP::NetworkingError)
      end

      def server?(error)
        (500..599).cover?(error.http_status)
      end

      def modeled_retryable?(error)
        error.is_a?(Hearth::ApiError) && error.retryable?
      end

      def modeled_throttling?(error)
        error.is_a?(Hearth::ApiError) && error.throttling?
      end
    end
  end
end
