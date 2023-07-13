# frozen_string_literal: true

module Hearth
  # @api private
  class MiddlewareStack
    def initialize
      @middleware = []
    end

    def use(middleware, **middleware_kwargs)
      @middleware.push([middleware, middleware_kwargs])
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
      @middleware.reverse_each do |(middleware, middleware_args)|
        app = middleware.new(app, **middleware_args)
      end
      app
    end
  end
end
