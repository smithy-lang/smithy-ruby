# frozen_string_literal: true

# This is generated code!

module Weather
  # @api private
  module Waiters
    # @api private
    class CityDeleted
      def initialize(options = {})
        @client = options[:client]
        @waiter = Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 2,
          max_delay: options[:max_delay] || 120,
          poller: Poller.new(
            operation_name: get_city,
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
    class CityExists
      def initialize(options = {})
        @client = options[:client]
        @waiter = Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 2,
          max_delay: options[:max_delay] || 120,
          poller: Poller.new(
            operation_name: get_city,
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

    # @api private
    class ForecastExists
      def initialize(options = {})
        @client = options[:client]
        @waiter = Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 2,
          max_delay: options[:max_delay] || 120,
          poller: Poller.new(
            operation_name: get_forecast,
            acceptors: [
              {
                "state" => "failure",
                "matcher" => {
                  "output" => {
                    "path" => "status",
                    "comparator" => "stringEquals",
                    "expected" => "failed"
                  }
                }
              },
              {
                "state" => "success",
                "matcher" => {
                  "output" => {
                    "path" => "status",
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