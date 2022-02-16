# frozen_string_literal: true

module Hearth
  module HTTP
    # Uses HTTP specific logic + Protocol defined Errors and
    # Error Code function to determine if a response should
    # be parsed as an Error. Contains generic Error parsing
    # logic as well.
    # @api private
    class ErrorParser
      # @api private
      HTTP_3XX = (300..399).freeze

      # @api private
      HTTP_4XX = (400..499).freeze

      # @api private
      HTTP_5XX = (500..599).freeze

      # @param [Module] error_module The code generated Errors module.
      #   Must contain service specific implementations of
      #   ApiRedirectError, ApiClientError, and ApiServerError
      #
      # @param [Integer] success_status The status code of a
      #   successful response as defined by the model for
      #   this operation. If this is a non 2XX value,
      #   the request will be considered successful if
      #   it has the success_status and does not
      #   have an error code.
      #
      # @param [Array<Class<ApiError>>] errors Array of Error classes
      #   modeled for the operation.
      #
      # @param [callable] error_code_fn Protocol specific function
      #   that will return the error code from a response, or nil if
      #   there is none.
      def initialize(error_module:, success_status:, errors:, error_code_fn:)
        @error_module = error_module
        @success_status = success_status
        @errors = errors
        @error_code_fn = error_code_fn
      end

      # Parse and return the error if the response is not successful.
      #
      # @param [Response] response The HTTP response
      def parse(response)
        extract_error(response) if error?(response)
      end

      private

      # Implements the following order of precedence
      # 1. Response has error_code -> error
      # 2. Response code == http trait status code? -> success
      # 3. Response code matches any error status codes? -> error
      #   [EXCLUDED, covered by error_code]
      # 4. Response code is 2xx? -> success
      # 6. Response code 5xx -> unknown server error
      #   [MODIFIED, 3xx, 4xx, 5xx mapped, everything else is Generic ApiError]
      # 7. Everything else -> unknown client error
      def error?(http_resp)
        return true if @error_code_fn.call(http_resp)
        return false if http_resp.status == @success_status

        !(200..299).cover?(http_resp.status)
      end

      def extract_error(http_resp)
        error_code = @error_code_fn.call(http_resp)
        error_class = error_class(error_code) if error_code

        error_opts = {
          http_resp: http_resp,
          error_code: error_code,
          message: error_code # default message
        }

        if error_class
          error_class.new(**error_opts)
        else
          generic_error(error_opts)
        end
      end

      def error_class(error_code)
        @errors.find do |e|
          e.name.include? error_code
        end
      end

      def generic_error(error_opts)
        http_resp = error_opts[:http_resp]
        case http_resp.status
        when HTTP_3XX then @error_module::ApiRedirectError.new(
          location: http_resp.headers['location'], **error_opts
        )
        when HTTP_4XX then @error_module::ApiClientError.new(**error_opts)
        when HTTP_5XX then @error_module::ApiServerError.new(**error_opts)
        else @error_module::ApiError.new(**error_opts)
        end
      end
    end
  end
end
