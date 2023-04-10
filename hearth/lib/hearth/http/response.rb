# frozen_string_literal: true

module Hearth
  module HTTP
    # Represents an HTTP Response.
    # @api private
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
      end

      # @return [Integer]
      attr_accessor :status

      # @return [String, nil]
      attr_accessor :reason

      # @return [Fields]
      attr_accessor :fields

      # Resets the HTTP response.
      # @return [Response]
      def reset
        @status = 0
        @reason = nil
        @fields.clear
        @body.truncate(0)
        self
      end
    end
  end
end
