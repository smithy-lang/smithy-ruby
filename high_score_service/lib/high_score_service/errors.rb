# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
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

    class BadRequestException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::BadRequestException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class ComplexError < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::ComplexError.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class CustomCodeError < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::CustomCodeError.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
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

    class FooError < ApiServerError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::FooError.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class InternalServerException < ApiServerError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::InternalServerException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class InvalidGreeting < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::InvalidGreeting.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class InvalidInputException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::InvalidInputException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class InvalidParameterValueException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::InvalidParameterValueException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class LimitExceededException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::LimitExceededException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class MissingParameterValueException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::MissingParameterValueException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class NoSuchBucket < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::NoSuchBucket.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class PredictorNotMountedException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::PredictorNotMountedException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class RequestTimeoutException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::RequestTimeoutException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class ResourceNotFoundException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::ResourceNotFoundException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class ServiceUnavailableException < ApiServerError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::ServiceUnavailableException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class TooManyRequestsException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::TooManyRequestsException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

    class UnauthorizedException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::UnauthorizedException.parse(http_resp)
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

    class ValidationException < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::ValidationException.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      attr_reader :data
    end

  end
end
