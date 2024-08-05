# frozen_string_literal: true

module Hearth
  module HTTP2
    # Represents an HTTP2 Response.
    class Response < HTTP::Response
      # @param (see Hearth::HTTP::Response#initialize)
      def initialize(**kwargs)
        super
        @stream = nil
        @sync_queue = Thread::Queue.new
      end

      # @return [HTTP2::Stream]
      attr_accessor :stream

      # @return [Queue]
      attr_reader :sync_queue
    end
  end
end
