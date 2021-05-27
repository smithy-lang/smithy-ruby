module SampleService
  module Waiters

    class HighScoreExists
      def initialize(client, options = {})
        @client = client
        @waiter = Seahorse::Waiters::Waiter.new(
          max_wait_time: options[:max_wait_time],
          min_delay: 2 || options[:min_delay], # code gen from trait
          max_delay: 120 || options[:max_delay], # code gen from trait
          before_attempt: options[:before_attempt],
          before_wait: options[:before_wait],
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
        )
        @tags = ['tag', 'other-tag'] # code gen from trait
      end

      attr_reader :tags

      def wait(params = {}, options = {})
        @waiter.wait(@client, params, options)
      end
    end

  end
end
