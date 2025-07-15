# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    module Features
      def self.clear
        Thread.current[:smithy_ruby_user_agent_metric] = []
      end

      def self.with_metric(*metrics, &block)
        Thread.current[:smithy_ruby_user_agent_metric] ||= []
        Thread.current[:smithy_ruby_user_agent_metric].concat(metrics)
        block.call
      ensure
        Thread.current[:smithy_ruby_user_agent_metric].pop(metrics.size)
      end
    end
  end
end
