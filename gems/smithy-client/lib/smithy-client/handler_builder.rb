# frozen_string_literal: true

module Smithy
  module Client
    # This module provides the ability to add handlers to a class or
    # module. The including class or extending module must respond to
    # `#handlers`, returning a {HandlerList}.
    module HandlerBuilder
      def handle(*args, &block)
        options = args.last.is_a?(Hash) ? args.pop : {}
        handler_class = block ? handler_for(*args, &block) : args.first
        handlers.add(handler_class, options)
      end
      alias handler handle

      private

      def handler_for(name = nil, &block)
        if name
          const_set(name, new_handler(block))
        else
          new_handler(block)
        end
      end

      def new_handler(block)
        Class.new(Handler) do
          define_method(:call, &block)
        end
      end
    end
  end
end
