# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module Weather
  module Waiters

    class CityExists
      # @param [Client] client
      #
      # @param [Hash] options
      #
      # @option options [required, Integer] :max_wait_time
      #   The maximum time in seconds to wait before the waiter gives up.
      #
      # @option options [Integer] :min_delay (2)
      #   The minimum time in seconds to delay polling attempts.
      #
      # @option options [Integer] :max_delay (120)
      #   The maximum time in seconds to delay polling attempts.
      #
      def initialize(client, options = {})
        @client = client
        @waiter = Hearth::Waiters::Waiter.new({
          max_wait_time: options[:max_wait_time],
          min_delay: 2 || options[:min_delay],
          max_delay: 120 || options[:max_delay],
          poller: Hearth::Waiters::Poller.new(
            operation_name: :get_city,
            acceptors: [
              {
                state: 'failure',
                matcher: {
                  errorType: 'NoSuchResource'
                }
              },
              {
                state: 'failure',
                matcher: {
                  errorType: 'UnModeledError'
                }
              },
              {
                state: 'success',
                matcher: {
                  success: true
                }
              },
              {
                state: 'retry',
                matcher: {
                  inputOutput: {
                    path: "length(\"input\".\"city_id\") == length(\"output\".\"member_name\")",
                    comparator: "booleanEquals",
                    expected: 'true'
                  }
                }
              },
              {
                state: 'success',
                matcher: {
                  output: {
                    path: "\"member_name\"",
                    comparator: "stringEquals",
                    expected: 'seattle'
                  }
                }
              }
            ]
          )
        }.merge(options))
        @tags = []
      end

      attr_reader :tags

      # @param [Hash] params
      #   (see Client#get_city)
      #
      # @param [Hash] options
      #   (see Client#get_city)
      #
      # @return [Types::GetCity]
      #   (see Client#get_city)
      #
      def wait(params = {}, options = {})
        @waiter.wait(@client, params, options)
      end
    end

    class ListContainsCity
      # @param [Client] client
      #
      # @param [Hash] options
      #
      # @option options [required, Integer] :max_wait_time
      #   The maximum time in seconds to wait before the waiter gives up.
      #
      # @option options [Integer] :min_delay (2)
      #   The minimum time in seconds to delay polling attempts.
      #
      # @option options [Integer] :max_delay (120)
      #   The maximum time in seconds to delay polling attempts.
      #
      def initialize(client, options = {})
        @client = client
        @waiter = Hearth::Waiters::Waiter.new({
          max_wait_time: options[:max_wait_time],
          min_delay: 2 || options[:min_delay],
          max_delay: 120 || options[:max_delay],
          poller: Hearth::Waiters::Poller.new(
            operation_name: :list_cities,
            acceptors: [
              {
                state: 'failure',
                matcher: {
                  output: {
                    path: "\"items\"[].\"member_name\"",
                    comparator: "allStringEquals",
                    expected: 'seattle'
                  }
                }
              },
              {
                state: 'success',
                matcher: {
                  output: {
                    path: "\"items\"[].\"member_name\"",
                    comparator: "anyStringEquals",
                    expected: 'NewYork'
                  }
                }
              }
            ]
          )
        }.merge(options))
        @tags = []
      end

      attr_reader :tags

      # @param [Hash] params
      #   (see Client#list_cities)
      #
      # @param [Hash] options
      #   (see Client#list_cities)
      #
      # @return [Types::ListCities]
      #   (see Client#list_cities)
      #
      def wait(params = {}, options = {})
        @waiter.wait(@client, params, options)
      end
    end

  end
end
