# frozen_string_literal: true

module Hearth
  module Auth
    # Base class for all authentication classes.
    class Identity
      def initialize(expiration: nil)
        @expiration = expiration
      end

      # @return [Time, nil]
      attr_reader :expiration
    end
  end
end
