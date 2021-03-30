module SampleService
  module Errors
    # Given an http_resp, return the error code
    # nil if no error code is present
    # This is codegen based on @RailsJson service definition
    def self.error_code(http_resp)
      http_resp.headers['x-smithy-error']
    end

    # Base class for all errors returned by this service
    class ApiError < Seahorse::HTTP::ApiError; end

    # Base class for all errors returned where the service returned
    # a 3XX redirection.
    class ApiRedirectError < ApiError
      def initialize(location:, **kwargs)
        @location = location
        super(**kwargs)
      end

      # @return [String]
      attr_reader :location
    end

    # Base class for all errors returned where the client is at fault.
    # These are generally errors with 4XX HTTP status codes.
    class ApiClientError < ApiError; end

    # Base class for all errors returned where the server is at fault.
    # These are generally errors with 5XX HTTP status codes.
    class ApiServerError < ApiError; end

    class UnprocessableEntityError < ApiClientError
      def initialize(http_resp:, **kwargs)
        @data = Parsers::UnprocessableEntityError.parse(http_resp)
        kwargs[:message] = @data.message if @data.respond_to?(:message)
        super(http_resp: http_resp, **kwargs)
      end

      # @return [Types::UnprocessableEntityError]
      attr_reader :data
    end
  end
end
