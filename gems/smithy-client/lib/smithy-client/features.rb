# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    module Features
      def self.track(*metrics, &block)
        Thread.current[:smithy_ruby_features] ||= []
        Thread.current[:smithy_ruby_features].concat(metrics)
        block.call
      ensure
        Thread.current[:smithy_ruby_features].pop(metrics.size)
      end

      def self.tracked
        Thread.current[:smithy_ruby_features] || []
      end
    end
  end
end
