# frozen_string_literal: true

module Hearth
  module EventStream
    # Represents an EventStream Message.
    class Message
      def initialize(headers: {}, payload: StringIO.new)
        @headers = headers
        @payload = payload
      end

      # @return [Hash] headers of a message
      attr_accessor :headers

      # @return [IO] payload of a message, size not exceed 16MB.
      attr_accessor :payload
    end
  end
end
