# frozen_string_literal: true

module Hearth
  module HTTP
    # Represents an HTTP Response.
    class Response < Hearth::Response
      # @param [Integer] status
      # @param [String, nil] reason
      # @param [Fields] fields
      # @param (see Hearth::Response#initialize)
      def initialize(status: 0, reason: nil, fields: Fields.new, **kwargs)
        super(**kwargs)
        @status = status
        @reason = reason
        @fields = fields
        @headers = Fields::Proxy.new(@fields, :header)
        @trailers = Fields::Proxy.new(@fields, :trailer)
      end

      # @return [Integer]
      attr_accessor :status

      # @return [String, nil]
      attr_accessor :reason

      # @return [Fields]
      attr_reader :fields

      # @return [Fields::Proxy]
      attr_reader :headers

      # @return [Fields::Proxy]
      attr_reader :trailers

      # Replace attributes from other response
      # @param [Response] other
      # @return [Response]
      def replace(other)
        @status = other.status
        @reason = other.reason
        @fields = other.fields
        @headers = Fields::Proxy.new(@fields, :header)
        @trailers = Fields::Proxy.new(@fields, :trailer)

        super
      end

      # Resets the HTTP response.
      # @return [Response]
      def reset
        @status = 0
        @reason = nil
        @fields.clear
        super
      end

      # Contains attributes for Telemetry span to emit.
      # @return [Hash]
      def span_attributes
        {
          'http.status_code' => status
        }.tap do |h|
          if headers.key?('Content-Length')
            h['http.response_content_length'] =
              headers['Content-Length']
          end
        end
      end
    end
  end
end
