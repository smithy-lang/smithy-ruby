# frozen_string_literal: true

module Seahorse
  module Middleware
    class Parse

      def initialize(app, error_parser:, data_parser:, output:)
        @app = app
        @error_parser = error_parser
        @data_parser = data_parser
        @output = output
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, context:)
        response = @app.call(
          request: request,
          context: context
        )
        parse_error(response, @output) unless @output.error
        parse_data(response, @output) unless @output.error
        response
      end

      private

      def parse_error(response, output)
        output.error = @error_parser.parse(response)
      end

      def parse_data(response, output)
        output.data = @data_parser.parse(response)
      end
    end
  end
end
