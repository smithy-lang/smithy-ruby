# frozen_string_literal: true

require 'jmespath'

module Seahorse
  module Waiters

    class Poller
      # @api private
      def initialize(options = {})
        @operation_name = options[:operation_name]
        @acceptors = options[:acceptors]
        # @input = nil
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
          # options = options.merge(input_output_middleware)
          response = client.send(@operation_name, params, options)
        rescue Seahorse::ApiError => e
          error = e
        end
        @acceptors.each do |acceptor|
          if acceptor_matches?(acceptor[:matcher], response, error)
            return [acceptor[:state].to_sym, response]
          end
        end
        [error ? :error : :retry, response]
      end

      private

      # def input_output_middleware
      #   middleware = ->(app, input, context) do
      #     @input = input # get internal details of middleware
      #     app.call(input, context)
      #   end
      #   { middleware: MiddlewareBuilder.before_send(middleware) }
      # end

      # TODO - refactor big time
      def acceptor_matches?(matcher, response, error)
        if (m = matcher[:success])
          if m == true && response
            return true
          elsif m == false && error
            return true
          end
          return false
        elsif (m = matcher[:errorType])
          if error.class.to_s.include?(m) || error.error_code == m
            return true
          else
            return false
          end
        elsif (m = matcher[:inputOutput])
          # todo - how to handle jmespath for an expression with two data sets?
          return false
        elsif (m = matcher[:output])
          if error.nil?
            return send("matches_#{m[:comparator]}?", search(m[:path], response), m[:expected])
          end
          return false
        end
      end

      def search(path, data)
        JMESPath.search(path, data)
      end

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

    end
  end
end
