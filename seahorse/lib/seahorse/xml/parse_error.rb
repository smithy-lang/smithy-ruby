# frozen_string_literal: true

module Seahorse
  module XML
    class ParseError < StandardError

      def initialize(error_or_message)
        if error_or_message.is_a?(StandardError)
          @original_error = error_or_message
          super(error_or_message.message)
        else
          super(error_or_message)
        end
      end

      # @return [StandardError, nil]
      attr_reader :original_error

    end
  end
end
