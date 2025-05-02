# frozen_string_literal: true

# This is generated code!

require 'smithy-client/waiters'

module Weather

  # @api private
  module Waiters
    # @api private
    #
    # Waits until city is deleted
    #
    class CityDeleted
      def initialize(options = {})
        @client = options[:client]
        @waiter = Smithy::Client::Waiters::Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 2,
          max_delay: options[:max_delay] || 120,
          poller: Smithy::Client::Waiters::Poller.new(
            operation_name: :get_city,
            acceptors: [{
              "state" => "success",
              "matcher" => {
                "errorType" => "NoSuchResource"
              }
            }]
          )
        )
      end

      def wait(params = {})
        @waiter.wait(@client, params)
      end
    end

    # @api private
    #
    # Waits until city exists
    #
    class CityExists
      def initialize(options = {})
        @client = options[:client]
        @waiter = Smithy::Client::Waiters::Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 2,
          max_delay: options[:max_delay] || 120,
          poller: Smithy::Client::Waiters::Poller.new(
            operation_name: :get_city,
            acceptors: [{
              "state" => "success",
              "matcher" => {
                "success" => true
              }
            }]
          )
        )
      end

      def wait(params = {})
        @waiter.wait(@client, params)
      end
    end

    # @deprecated
    # @api private
    #
    # Waits until forecast is created
    #
    class ForecastExists
      def initialize(options = {})
        @client = options[:client]
        @waiter = Smithy::Client::Waiters::Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 5,
          max_delay: options[:max_delay] || 20,
          poller: Smithy::Client::Waiters::Poller.new(
            operation_name: :get_forecast,
            acceptors: [
              {
                "state" => "failure",
                "matcher" => {
                  "output" => {
                    "path" => "status_property",
                    "comparator" => "stringEquals",
                    "expected" => "failed"
                  }
                }
              },
              {
                "state" => "success",
                "matcher" => {
                  "output" => {
                    "path" => "status_property",
                    "comparator" => "stringEquals",
                    "expected" => "success"
                  }
                }
              }
            ]
          )
        )
      end

      def wait(params = {})
        @waiter.wait(@client, params)
      end
    end

  end
end