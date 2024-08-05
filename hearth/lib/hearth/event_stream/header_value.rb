# frozen_string_literal: true

module Hearth
  module EventStream
    # Represents a HeaderValue in an EventStream::Message.
    class HeaderValue
      def initialize(value:, type:)
        @value = value
        @type = type
      end

      # @return [Object] value
      attr_reader :value

      # @return [String] type
      attr_reader :type
    end
  end
end
