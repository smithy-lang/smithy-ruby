# frozen_string_literal: true

require 'pathname'

module Smithy
  module Client
    # A log formatter generates a string for logging from output. This is
    # accomplished with a log pattern string:
    #
    #     pattern = ':operation :http_response_status_code :time'
    #     formatter = Smithy::Client::LogFormatter.new(pattern)
    #     formatter.format(response)
    #     #=> 'list_cities 200 0.0352'
    #
    # # Canned Formatters
    #
    # Instead of providing your own pattern, you can choose a canned log
    # formatter.
    #
    # * {Formatter.default}
    # * {Formatter.colored}
    # * {Formatter.short}
    #
    # # Pattern Substitutions
    #
    # You can put any of these placeholders into your pattern.
    #
    #   * `:client_class` - The name of the client class.
    #   * `:operation` - The name of the client request method.
    #   * `:request_params` - The user provided parameters. Long strings are truncated/summarized if
    #      they exceed the `:max_string_size`. Other objects are inspected.
    #   * `:time` - The total time in seconds spent on the request.
    #      This includes client side time spent building the request and parsing the response.
    #   * `:retries` - The number of times a client request was retried.
    #   * `:http_request_method` - The http request verb, e.g., `POST`, `PUT`, `GET`, etc.
    #   * `:http_request_endpoint` - The request endpoint. This includes the scheme, host and port, but not the path.
    #   * `:http_request_scheme` - This is replaced by `http` or `https`.
    #   * `:http_request_host` - The host name of the http request endpoint (e.g. 'example.com').
    #   * `:http_request_port` - The port number (e.g. '443' or '80').
    #   * `:http_request_headers` - The http request headers, inspected.
    #   * `:http_request_body` - The http request payload.
    #   * `:http_response_status_code` - The http response status code, e.g., `200`, `404`, `500`, etc.
    #   * `:http_response_headers` - The http response headers, inspected.
    #   * `:http_response_body` - The http response body contents.
    #   * `:error_class` - The class of the error that occurred, if any.
    #   * `:error_message` - The error message, if an error occurred.
    #
    class LogFormatter
      # @param [String] pattern The log format pattern should be a string and may contain substitutions.
      # @option options [Integer] :max_string_size (1000) When summarizing
      #  request parameters, strings longer than this value will be truncated.
      # @option options [Boolean] :filter_sensitive_params (true) When false, sensitive params will
      #  not be filtered when logging `:params`.
      def initialize(pattern, options = {})
        @pattern = pattern
        @log_param_formatter = LogParamFormatter.new(options)
        @log_param_filter = LogParamFilter.new(options)
      end

      # @return [String]
      attr_reader :pattern

      # Given a response, this will format a log message and return it as a string according to {#pattern}.
      # @param [Smithy::Client::Response] response
      # @return [String]
      def format(response)
        pattern.gsub(/:(\w+)/) { |sym| send("_#{sym[1..]}", response) }
      end

      private

      def _client_class(response)
        response.context.client.class.name
      end

      def _operation(response)
        response.context.operation_name
      end

      def _request_params(response)
        params = response.context.params
        input = response.context.operation.input
        @log_param_formatter.summarize(@log_param_filter.filter(input, params))
      end

      def _time(response)
        duration = response.context[:logging_completed_at] - response.context[:logging_started_at]
        Kernel.format('%.06f', duration).sub(/0+$/, '')
      end

      def _retries(response)
        response.context.retries
      end

      def _http_request_endpoint(response)
        response.context.http_request.endpoint.to_s
      end

      def _http_request_scheme(response)
        response.context.http_request.endpoint.scheme
      end

      def _http_request_host(response)
        response.context.http_request.endpoint.host
      end

      def _http_request_port(response)
        response.context.http_request.endpoint.port
      end

      def _http_request_method(response)
        response.context.http_request.http_method
      end

      def _http_request_headers(response)
        response.context.http_request.headers.inspect
      end

      def _http_request_body(response)
        body = response.context.http_request.body
        return '' unless body.respond_to?(:rewind)

        body_contents = body.read
        body.rewind
        @log_param_formatter.summarize(body_contents)
      end

      def _http_response_status_code(response)
        response.context.http_response.status_code
      end

      def _http_response_headers(response)
        response.context.http_response.headers.inspect
      end

      def _http_response_body(response)
        body = response.context.http_response.body
        return '' unless body.respond_to?(:rewind)

        body_contents = body.read
        body.rewind
        @log_param_formatter.summarize(body_contents)
      end

      def _error_class(response)
        response.error ? response.error.class.name : ''
      end

      def _error_message(response)
        response.error ? response.error.message : ''
      end

      class << self
        # The default log format.
        # @option (see #initialize)
        # @example A sample of the default format.
        #
        #     [ClientClass 200 0.580066 0 retries] list_objects(:bucket_name => 'bucket')
        #
        # @return [Formatter]
        def default(options = {})
          pattern = []
          pattern << '[:client_class'
          pattern << ':http_response_status_code'
          pattern << ':time'
          pattern << ':retries retries]'
          pattern << ':operation(:request_params)'
          pattern << ':error_class'
          pattern << ':error_message'
          LogFormatter.new("#{pattern.join(' ')}\n", options)
        end

        # The short log format.  Similar to default, but it does not
        # inspect the request params or report on retries.
        # @option (see #initialize)
        # @example A sample of the short format
        #
        #     [ClientClass 200 0.494532] list_buckets
        #
        # @return [Formatter]
        def short(options = {})
          pattern = []
          pattern << '[:client_class'
          pattern << ':http_response_status_code'
          pattern << ':time]'
          pattern << ':operation'
          pattern << ':error_class'
          LogFormatter.new("#{pattern.join(' ')}\n", options)
        end

        # The default log format with ANSI colors.
        # @option (see #initialize)
        # @example A sample of the colored format (sans the ansi colors).
        #
        #     [ClientClass 200 0.580066 0 retries] list_objects(:bucket_name => 'bucket')
        #
        # @return [Formatter]
        def colored(options = {})
          bold = "\x1b[1m"
          color = "\x1b[34m"
          reset = "\x1b[0m"
          pattern = []
          pattern << "#{bold}#{color}[:client_class"
          pattern << ':http_response_status_code'
          pattern << ':time'
          pattern << ":retries retries]#{reset}#{bold}"
          pattern << ':operation(:request_params)'
          pattern << ':error_class'
          pattern << ":error_message#{reset}"
          LogFormatter.new("#{pattern.join(' ')}\n", options)
        end
      end
    end
  end
end
