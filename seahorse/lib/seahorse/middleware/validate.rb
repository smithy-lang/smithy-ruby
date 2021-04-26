# frozen_string_literal: true

module Seahorse
  # @api private
  module Middleware
    class Validate

      def initialize(app, validator:, validate_params:, input:)
        @app = app
        @validator = validator
        @validate_params = validate_params
        @input = input
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, response:, context:)
        if @validate_params
          @validator.validate!(params: @input, context: 'params')
        end
        @app.call(
          request: request,
          response: response,
          context: context
        )
      end

    end
  end
end
