# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware used to validate input.
    # @api private
    class Validate
      include Middleware::Logging

      # @param [Class] app The next middleware in the stack.
      # @param [Boolean] validate_input If true, the input is validated against
      #   the model and an error is raised for unexpected types.
      # @param [Class] validator A validator object responsible for validating
      #  the input. It must respond to #validate! and take input and a context
      #  as arguments.
      def initialize(app, validate_input:, validator:)
        @app = app
        @validate_input = validate_input
        @validator = validator
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        validate_input(input, context) if @validate_input
        @app.call(input, context)
      end

      private

      def validate_input(input, context)
        log_debug(context, "Validating input with: #{input}")
        @validator.validate!(input, context: 'input')
        log_debug(context, 'Validated input')
      end
    end
  end
end
