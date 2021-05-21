# frozen_string_literal: true

module Seahorse
  # @api private
  module Middleware
    class Validate

      def initialize(app, validator:, validate_input:, input:)
        @app = app
        @validator = validator
        @validate_input = validate_input
        @input = input
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, context:)
        if @validate_input
          @validator.validate!(input: @input, context: 'input')
        end
        @app.call(
          request: request,
          context: context
        )
      end

    end
  end
end
