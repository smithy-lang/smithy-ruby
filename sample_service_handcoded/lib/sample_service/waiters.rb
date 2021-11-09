module SampleService
  module Waiters

    class HighScoreExists
      # @param [Client] client
      # @param [Hash] options
      # @option options [required, Integer] :max_wait_time The maximum time in
      #   seconds to wait before the waiter gives up.
      # @option options [Integer] :min_delay (2) The minimum time in seconds to
      #   delay polling attempts.
      # @option options [Integer] :max_delay (120) The maximum time in seconds
      #   to delay polling attempts.
      def initialize(client, options = {})
        @client = client
        @waiter = Seahorse::Waiters::Waiter.new({
          max_wait_time: options[:max_wait_time], # required
          min_delay: 2 || options[:min_delay], # code gen from trait
          max_delay: 120 || options[:max_delay], # code gen from trait
          poller: Seahorse::Waiters::Poller.new(
            operation_name: :create_high_score, # code gen operation name from trait
            acceptors: [ # code gen list of acceptors from trait
              {
                state: "success",
                matcher: {
                  success: true
                }
              },
              {
                state: "retry",
                matcher: {
                  errorType: "UnprocessableEntityError"
                }
              }
            ]
          )
        }.merge(options))
        @tags = %w[foo bar]
      end

      attr_reader :tags

      # @param [Hash] params (see Client#create_high_score)
      # @param [Hash] options (see Client#create_high_score)
      # @return (see Client#head_bucket)
      def wait(params = {}, options = {})
        @waiter.wait(@client, params, options)
      end
    end

  end
end
