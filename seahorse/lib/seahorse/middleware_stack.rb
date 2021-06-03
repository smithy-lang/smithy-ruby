# frozen_string_literal: true

module Seahorse
  # @api private
  class MiddlewareStack
    def initialize
      @middleware = []
    end

    def use(middleware, **middleware_kwargs, &block)
      @middleware.push([middleware, middleware_kwargs, block])
    end

    def use_before(before, middleware, **middleware_kwargs, &block)
      new_middleware = []
      @middleware.each do |klass, args|
        if before == klass
          new_middleware << [middleware, middleware_kwargs, block]
        end
        new_middleware << [klass, args]
      end
      unless new_middleware.size == @middleware.size + 1
        raise "Failed to insert #{middleware} before #{before}"
      end

      @middleware = new_middleware
    end

    def use_after(after, middleware, **middleware_kwargs, &block)
      new_middleware = []
      @middleware.each do |klass, args|
        new_middleware << [klass, args]
        if after == klass
          new_middleware << [middleware, middleware_kwargs, block]
        end
      end
      unless new_middleware.size == @middleware.size + 1
        raise "Failed to insert #{middleware} after #{after}"
      end

      @middleware = new_middleware
    end

    # @param input
    # @param context
    # @return [Output]
    def run(input:, context:)
      stack.call(input, context)
    end

    private

    def stack
      app = nil
      @middleware.reverse_each do |(middleware, middleware_args, block)|
        app = middleware.new(app, **middleware_args, &block)
      end
      app
    end
  end
end
