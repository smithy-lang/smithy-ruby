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
      # @param context
      # @return [Output, Response]
      def call(request, context)
        output, response = @app.call(request, context)
        parse_error(response, output) unless output.error
        parse_data(response, output) unless output.error
        [output, response]
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
