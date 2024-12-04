# frozen_string_literal: true

module Smithy
  module Client
    # Base class for handlers in the client stack.
    class Handler
      # @param [Handler] handler (nil) The next handler in the stack that
      #  should be called from within the {#call} method. This value
      #  must only be nil for send handlers.
      def initialize(handler = nil)
        @handler = handler
      end

      # @return [Handler, nil]
      attr_accessor :handler

      # @param [Smithy::Client::RequestContext] context
      # @return [Smithy::Client::Response]
      def call(context)
        @handler.call(context)
      end

      def inspect
        "#<#{self.class.name || 'UnknownHandler'} @handler=#{@handler.inspect}>"
      end
    end
  end
end
