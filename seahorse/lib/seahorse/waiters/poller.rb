# frozen_string_literal: true

require 'jmespath'

module Seahorse
  module Waiters

    class Poller
      def initialize(options = {})
        @operation_name = options[:operation_name]
        @acceptors = options[:acceptors]
      end

      def call(client, params = {}, options = {})
        begin
          response = client.send(@operation_name, params, options)
        rescue Seahorse::ApiError => e
          error = e.class.to_s
        end
        @acceptors.each do |acceptor|
          if acceptor_matches?(acceptor[:matcher], response, error)
            return [acceptor[:state].to_sym, response]
          end
        end
        [error ? :error : :retry, response]
      end

      private

      def acceptor_matches?(matcher, response, error)
        if (m = matcher[:success])
          if m == true && response
            return true
          elsif m == false && error
            return true
          end
          return false
        elsif (m = matcher[:errorType])
          if error.include?(m)
            return true
          else
            return false
          end
        elsif (m = matcher[:inputOutput]) || (m = matcher[:output])
          send("matches_#{m[:comparator]}?", value(m[:path], response), m[:expected])
        else
          raise "Unknown matcher type"
        end
      end

      def value(path, response)
        JMESPath.search(path, response)
      end

      def matches_stringEquals?(value, expected)
        value == expected
      end

      def matches_booleanEquals(value, expected)
        value.to_s == expected
      end

      def matches_allStringEquals(values, expected)
        values.is_a?(Array) && values.size > 1 && values.all? { |v| v == expected }
      end

      def matches_anyStringEquals(values, expected)
        values.is_a?(Array) && values.any? { |v| v == expected }
      end

    end
  end
end
