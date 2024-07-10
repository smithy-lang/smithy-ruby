# frozen_string_literal: true

module Hearth
  # Module for EventStreams.
  module EventStream
    class HandlerBase

      def initialize
        @handlers = {}
        @error_handlers = []
      end

      attr_accessor :encoder

      def end_input_stream
        # TODO
      end

      def on_error(&block)
        @error_handlers << block
      end

      def on(type, callback)
        (@handlers[type] ||= []) << callback
      end

      def on_unknown_event(&block)
        on(:unknown, block)
      end

      # TODO: This should be code generated and use the parser to determine type
      # def emit(type, event)
      #   return unless @handlers[type]
      #   @handlers[type].each do |handler|
      #     handler.call(event)
      #   end
      # end

      def join
        # Wait until output stream is closed
        # TODO
      end

      def kill
        # terminates the output stream (before the service has sent an end stream)
        # TODO
      end

    end
  end
end
