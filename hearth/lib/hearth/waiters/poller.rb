# frozen_string_literal: true

require 'jmespath'

module Hearth
  module Waiters
    # Abstract Poller used by generated service Waiters. This class handles
    # sending the request and matching input or output.
    class Poller
      # @api private
      def initialize(options = {})
        @operation_name = options[:operation_name]
        @acceptors = options[:acceptors]
        @input = nil
      end

      # Makes an API call, returning the resultant state and the response.
      #
      # * `:success` - A success state has been matched.
      # * `:failure` - A terminate failure state has been matched.
      # * `:retry`   - The waiter may be retried.
      # * `:error`   - The waiter encountered an un-expected error.
      #
      # @example A trival (bad) example of a waiter that polls indefinetly.
      #
      #   loop do
      #
      #     state, resp = poller.call(client, params, options)
      #
      #     case state
      #     when :success then return true
      #     when :failure then return false
      #     when :retry   then next
      #     when :error   then raise 'oops'
      #     end
      #
      #   end
      #
      # @param [Client] client
      # @param [Hash] params
      # @param [Hash] options
      # @return [Array<Symbol,Response>]
      def call(client, params = {}, options = {})
        begin
          options = options.merge(input_output_middleware)
          response = client.send(@operation_name, params, options)
        rescue Hearth::ApiError => e
          error = e
        end
        resp_or_error = error || response
        @acceptors.each do |acceptor|
          if acceptor_matches?(acceptor[:matcher], response, error)
            return [acceptor[:state].to_sym, resp_or_error]
          end
        end
        [error ? :error : :retry, resp_or_error]
      end

      private

      def input_output_middleware
        middleware = lambda do |input, _context|
          @input = input # get internal details of middleware
        end
        { middleware: MiddlewareBuilder.before_send(middleware) }
      end

      def acceptor_matches?(matcher, response, error)
        if (m = matcher[:success])
          success_matcher?(m, response, error)
        elsif (m = matcher[:errorType])
          error_type_matcher?(m, error)
        elsif (m = matcher[:inputOutput])
          input_output_matcher?(m, response, error)
        elsif (m = matcher[:output])
          output_matcher?(m, response, error)
        end
      end

      def success_matcher?(matcher, response, error)
        (matcher == true && response) || (matcher == false && error)
      end

      def error_type_matcher?(matcher, error)
        # handle shape ID cases
        matcher = matcher.split('#').last.split('$').first
        error.class.to_s.include?(matcher) || error.error_code == matcher
      end

      def input_output_matcher?(matcher, response, error)
        return false if error

        data = { input: @input, output: response }
        send(
          "matches_#{matcher[:comparator]}?",
          JMESPath.search(matcher[:path], data),
          matcher[:expected]
        )
      end

      def output_matcher?(matcher, response, error)
        return false if error

        send(
          "matches_#{matcher[:comparator]}?",
          JMESPath.search(matcher[:path], response),
          matcher[:expected]
        )
      end

      # rubocop:disable Naming/MethodName
      def matches_stringEquals?(value, expected)
        value == expected
      end

      def matches_booleanEquals?(value, expected)
        value.to_s == expected
      end

      def matches_allStringEquals?(values, expected)
        values.is_a?(Array) && !values.empty? &&
          values.all? { |v| v == expected }
      end

      def matches_anyStringEquals?(values, expected)
        values.is_a?(Array) && !values.empty? &&
          values.any? { |v| v == expected }
      end
      # rubocop:enable Naming/MethodName
    end
  end
end
