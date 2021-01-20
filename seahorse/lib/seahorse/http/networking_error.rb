# frozen_string_literal: true

module Seahorse
  module HTTP
    # Thrown by {Xfer} when encountering a networking error while transmitting
    # a request or receiving a response. You can access the original error
    # by calling {#original_error}.
    class NetworkingError < StandardError

      MSG = 'Encountered an error while transmitting the request: %<message>s'

      def initialize(original_error)
        @original_error = original_error
        super(format(MSG, message: original_error.message))
      end

      # @return [StandardError]
      attr_reader :original_error

    end
  end
end
