# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/smithy-lang/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module HighScoreService
  module Waiters

    # Waits until a high score has been created
    class HighScoreExists
      # @param [Client] client
      # @param [Hash] options
      #   Waiter options
      # @option options [required, Integer] :max_wait_time
      #   The maximum time in seconds to wait before the waiter gives up.
      # @option options [Integer] :min_delay (2)
      #   The minimum time in seconds to delay polling attempts.
      # @option options [Integer] :max_delay (120)
      #   The maximum time in seconds to delay polling attempts.
      def initialize(client, options = {})
        @client = client
        @waiter = Hearth::Waiters::Waiter.new({
          max_wait_time: options[:max_wait_time],
          min_delay: options[:min_delay] || 2,
          max_delay: options[:max_delay] || 120,
          poller: Hearth::Waiters::Poller.new(
            operation_name: :get_high_score,
            acceptors: [
              {
                state: 'retry',
                matcher: {
                  errorType: 'NotFoundError'
                }
              },
              {
                state: 'success',
                matcher: {
                  success: true
                }
              }
            ]
          )
        }.merge(options))
        @tags = []
      end

      # @return [Array<String>]
      attr_reader :tags

      # @param (see Client#get_high_score)
      # @return [true]
      # @raise [Hearth::Waiters::FailureStateError]
      # @raise [Hearth::Waiters::MaxWaitTimeExceededError]
      # @raise [Hearth::Waiters::UnexpectedError]
      def wait(params = {}, options = {})
        @waiter.wait(@client, params, options)
      end
    end

  end
end
