# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Errors

    def self.error_code(http_resp)
      case http_resp.status
      when 300 then 'MultipleChoicesError'
      when 301 then 'MovedPermanentlyError'
      when 302 then 'FoundError'
      when 303 then 'SeeOtherError'
      when 304 then 'NotModifiedError'
      when 305 then 'UseProxyError'
      when 307 then 'TemporaryRedirectError'
      when 308 then 'PermanentRedirectError'
      when 400 then 'BadRequestError'
      when 401 then 'UnauthorizedError'
      when 402 then 'PaymentRequiredError'
      when 403 then 'ForbiddenError'
      when 404 then 'NotFoundError'
      when 405 then 'MethodNotAllowedError'
      when 406 then 'NotAcceptableError'
      when 407 then 'ProxyAuthenticationRequiredError'
      when 408 then 'RequestTimeoutError'
      when 409 then 'ConflictError'
      when 410 then 'GoneError'
      when 411 then 'LengthRequiredError'
      when 412 then 'PreconditionFailedError'
      when 413 then 'PayloadTooLargeError'
      when 414 then 'UriTooLongError'
      when 415 then 'UnsupportedMediaTypeError'
      when 416 then 'RangeNotSatisfiableError'
      when 417 then 'ExpectationFailedError'
      when 421 then 'MisdirectedRequestError'
      when 422 then 'UnprocessableEntityError'
      when 423 then 'LockedError'
      when 424 then 'FailedDependencyError'
      when 426 then 'UpgradeRequiredError'
      when 428 then 'PreconditionRequiredError'
      when 429 then 'TooManyRequestsError'
      when 431 then 'RequestHeaderFieldsTooLargeError'
      when 451 then 'UnavailableForLegalReasonsError'
      when 500 then 'InternalServerErrorError'
      when 501 then 'NotImplementedError'
      when 502 then 'BadGatewayError'
      when 503 then 'ServiceUnavailableError'
      when 504 then 'GatewayTimeoutError'
      when 505 then 'HttpVersionNotSupportedError'
      when 506 then 'VariantAlsoNegotiatesError'
      when 507 then 'InsufficientStorageError'
      when 508 then 'LoopDetectedError'
      when 510 then 'NotExtendedError'
      when 511 then 'NetworkAuthenticationRequiredError'
      end
    end

    # Base class for all errors returned by this service
    class ApiError < Hearth::HTTP::ApiError; end

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
        super(**kwargs)
      end

      # @return [String] location
      attr_reader :location
    end

    class UnprocessableEntityError < ApiClientError
      # @param [Hearth::HTTP::Response] http_resp
      #
      # @param [String] error_code
      #
      # @param [String] message
      #
      def initialize(http_resp:, **kwargs)
        @data = Parsers::UnprocessableEntityError.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)

        super(http_resp: http_resp, **kwargs)
      end

      # @return [Types::UnprocessableEntityError]
      #
      attr_reader :data
    end

  end
end
