# frozen_string_literal: true

module Smithy
  module Client
    # Base class for all Identity classes.
    class Identity
      def initialize(options = {})
        @expiration = options[:expiration]
      end

      # @return [Time, nil]
      attr_reader :expiration
    end
  end
end
