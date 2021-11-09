# frozen_string_literal: true

# WARNING ABOUT GENERATED CODE
#
# This file was code generated using smithy-ruby.
# https://github.com/awslabs/smithy-ruby
#
# WARNING ABOUT GENERATED CODE

module SampleService
  module Waiters
    # Wait until a high score exists
    class HighScoreExists
      # @param [Client] client
      # @param [Hash] options
      # @option options [required, Integer] :max_wait_time The maximum time in seconds
      # to wait before the waiter gives up.
      # @option options [Integer] :min_delay (2) The minimum time in seconds to delay
      # polling attempts.
      # @option options [Integer] :max_delay (120) The maximum time in seconds to delay
      # polling attempts.
      def initialize(client, options = {})
        @client = client
        @waiter = Seahorse::Waiters::Waiter.new({
          max_wait_time: options[:max_wait_time],
          min_delay: 2 || options[:min_delay],
          max_delay: 120 || options[:max_delay],
          poller: Seahorse::Waiters::Poller.new(
            operation_name: create_high_score,
          )
        }.merge(options))
        @tags = []
      end


      attr_reader :tags


      # @param [Hash] params (see Client#create_high_score)
      # @param [Hash] options (see Client#create_high_score)
      # @return (see Client#create_high_score)
      def wait(params = {}, options = {})
        @waiter.wait(@client, params, options)
      end
    end
  end
end
