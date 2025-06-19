# frozen_string_literal: true

# This is generated code!

module Weather

  # @api private
  module Waiters
    # @api private
    #
    # Waits for a forecast to be available.
    #
    class ForecastExists
      def initialize(options = {})
        @client = options[:client]
        @waiter = Smithy::Client::Waiters::Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 2,
          max_delay: options[:max_delay] || 120,
          poller: Smithy::Client::Waiters::Poller.new(
            operation_name: :get_forecast,
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

  end
end