# frozen_string_literal: true

module Seahorse
  module Middleware
    class Build

      def initialize(app, builder:, input:)
        @app = app
        @builder = builder
        @input = input
      end

      # @param request
      # @param context
      # @return [Output, Response]
      def call(request, context)
        @builder.build(request, input: @input)
        @app.call(request, context)
      end

    end
  end
end
