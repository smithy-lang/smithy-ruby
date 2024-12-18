# frozen_string_literal: true

module Smithy
  module Client
    # Raised when a networking error occurs.
    class NetworkingError < StandardError
      # @param [StandardError] error
      def initialize(error)
        super(error.message)
        @original_error = error
      end

      attr_reader :original_error
    end
  end
end
