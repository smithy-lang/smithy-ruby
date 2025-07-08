# frozen_string_literal: true

require 'delegate'

module Smithy
  module Client
    # Represents the response for a service operation call.
    class Response < Delegator
      # @option options [HandlerContext] :context (nil)
      # @option options [Structure] :data (nil)
      # @option options [StandardError] :error (nil)
      def initialize(options = {})
        @context = options[:context] || HandlerContext.new
        @data = options[:data]
        @error = options[:error]
        @http_request = @context.http_request
        @http_response = @context.http_response
        @http_response.on_error { |error| @error = error }
        super(@error || @data)
      end

      # @return [HandlerContext]
      attr_reader :context

      # @return [Structure, nil] The response data. This may be `nil` if the
      #  response contains an {#error}.
      attr_accessor :data

      # @return [StandardError, nil] The error that occurred during the
      #  operation.  This will be `nil` if the operation was successful.
      attr_accessor :error

      # @overload on_done(status_code, &block)
      #   @param [Integer] status_code The block will be
      #     triggered only for responses with the given status code.
      #
      # @overload on_done(status_code_range, &block)
      #   @param [Range<Integer>] status_code_range The block will be
      #     triggered only for responses with a status code that falls
      #     within the given range.
      #
      # @return [self]
      def on_done(range = nil, &)
        response = self
        @http_response.on_done(range) do
          yield response
        end
        self
      end

      # Necessary to define as a subclass of Delegator
      # @api private
      def __getobj__(&)
        @error || @data
      end

      # Necessary to define as a subclass of Delegator
      # @api private
      def __setobj__(obj)
        if obj.is_a?(StandardError)
          @error = obj
        else
          @data = obj
        end
      end
    end
  end
end
