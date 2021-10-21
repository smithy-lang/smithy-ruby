# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Errors
    # Given an http_resp, return the error code
    def self.error_code(http_resp)
      http_resp.headers['x-smithy-error']
    end

    # Base class for all errors returned by this service
    class ApiError < Seahorse::HTTP::ApiError; end

    # Base class for all errors returned where the client is at fault.
    # These are generally errors with 4XX HTTP status codes.
    class ApiClientError < ApiError; end

    # Base class for all errors returned where the server is at fault.
    # These are generally errors with 5XX HTTP status codes.
    class ApiServerError < ApiError; end
    # Base class for all errors returned where the service returned
    # a 3XX redirection.
    class ApiRedirectError < ApiError
      def initialize(location:, **kwargs)
        @location = location
        super(kwargs)
      end

      # @return [String] location
      attr_reader :location
    end

    class ErrorWithMembers < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::ErrorWithMembers.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class ErrorWithoutMembers < ApiServerError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::ErrorWithoutMembers.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class UnprocessableEntityError < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::UnprocessableEntityError.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

  end
end
