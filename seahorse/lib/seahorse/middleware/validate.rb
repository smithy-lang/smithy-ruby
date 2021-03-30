# frozen_string_literal: true

module Seahorse
  # @api private
  module Middleware
    class Validate

      def initialize(app, validator:, params:, validate_params:)
        @app = app
        @validator = validator
        @params = params
        @validate_params = validate_params
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, response:, context:)
        @validator.validate(params: @params, context: 'params') if @validate_params
        @app.call(
          request: request,
          response: response,
          context: context
        )
      end

    end
  end
end
