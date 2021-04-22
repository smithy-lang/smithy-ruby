# frozen_string_literal: true

module Seahorse
  module Middleware
    class Parse

      def initialize(app, error_parser:, data_parser:)
        @app = app
        @error_parser = error_parser
        @data_parser = data_parser
      end

      # @param request
      # @param response
      # @param context
      # @return [Output]
      def call(request:, response:, context:)
        output = @app.call(
          request: request,
          response: response,
          context: context
        )
        parse_error(response, output) unless output.error
        parse_data(response, output) unless output.error
        output
      end

      private

      def parse_error(response, output)
        output.error = @error_parser.parse(
          response: response
        )
      end

      def parse_data(response, output)
        @data_parser.parse(
          response,
          output: output
        )
      end
    end
  end
end
