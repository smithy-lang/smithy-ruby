# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    module Features
      class << self
        def track(*features, &block)
          Thread.current[:smithy_ruby_features] ||= Set.new
          added = features.map { |f| Thread.current[:smithy_ruby_features].add?(f) }
          block.call
        ensure
          features.each_with_index { |f, i| Thread.current[:smithy_ruby_features].delete(f) if added[i] }
        end

        def tracked
          Thread.current[:smithy_ruby_features] || Set.new
        end
      end
    end
  end
end
