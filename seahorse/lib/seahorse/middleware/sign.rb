# frozen_string_literal: true

module Seahorse
  # @api private
  module Middleware
    class Sign

      def initialize(app, signer:)
        @app = app
        @signer = signer
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, response:, context:)
        @signer.sign_request(request) if @signer
        @app.call(
          request: request,
          response: response,
          context: context
        )
      end

    end
  end
end
