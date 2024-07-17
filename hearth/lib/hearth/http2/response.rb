# frozen_string_literal: true

require_relative '../http/response'

module Hearth
  module HTTP2
    # Represents an HTTP2 Response.
    class Response < Hearth::HTTP::Response
      # @param (see Hearth::HTTP::Response#initialize)
      def initialize(**kwargs)
        super(**kwargs)
        @stream = nil
        @sync_queue = Queue.new
      end

      attr_accessor :stream

      attr_reader :sync_queue
    end
  end
end
