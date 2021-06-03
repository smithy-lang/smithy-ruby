# frozen_string_literal: true

module Seahorse
  # @api private
  module Middleware
    class Validate
      def initialize(app, validator:, validate_input:)
        @app = app
        @validator = validator
        @validate_input = validate_input
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        @validator.validate!(input: input, context: 'input') if @validate_input
        @app.call(input, context)
      end
    end
  end
end
