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
      # @return [Types::<Operation>Output]
      def call(input, context)
        if @validate_input
          @validator.validate!(input: input, context: 'input')
        end
        @app.call(input, context)
      end

    end
  end
end
