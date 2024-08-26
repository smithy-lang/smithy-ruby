# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module WhiteLabel
  module Errors
    def self.error_code(resp)
      resp.headers['x-smithy-error']
    end

    # Base class for all errors returned by this service
    class ApiError < Hearth::ApiError; end

    # Base class for all errors returned where the client is at fault.
    class ApiClientError < ApiError; end

    # Base class for all errors returned where the server is at fault.
    class ApiServerError < ApiError; end

    # Base class for all errors returned where the service returned
    # a redirection.
    class ApiRedirectError < ApiError
      def initialize(location:, **kwargs)
        @location = location
        super(**kwargs)
      end

      # @return [String] location
      attr_reader :location
    end

    class ClientError < ApiClientError
      def initialize(data:, **kwargs)
        @data = data
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(**kwargs)
      end

      # @return [Types::ClientError]
      attr_reader :data

      def retryable?
        true
      end
    end

    class ServerError < ApiServerError
      def initialize(data:, **kwargs)
        @data = data
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(**kwargs)
      end

      # @return [Types::ServerError]
      attr_reader :data

      def retryable?
        true
      end

      def throttling?
        true
      end
    end

    class ServerErrorEvent < ApiServerError
      def initialize(data:, **kwargs)
        @data = data
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(**kwargs)
      end

      # @return [Types::ServerErrorEvent]
      attr_reader :data
    end

  end
end
