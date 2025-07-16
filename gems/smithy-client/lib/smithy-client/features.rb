# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    module Features
      class << self
        def track(*features, &block)
          Thread.current[:smithy_ruby_features] ||= []
          Thread.current[:smithy_ruby_features].concat(features)
          block.call
        ensure
          Thread.current[:smithy_ruby_features].pop(features.size)
        end

        def tracked
          Thread.current[:smithy_ruby_features] || []
        end
      end
    end
  end
end
