# frozen_string_literal: true

module Seahorse
  module Middleware
    class Parse

      def initialize(app, error_parser:, data_parser:)
        @app = app
        @error_parser = error_parser
        @data_parser = data_parser
      end

      # @param input
      # @param context
      # @return [Types::<Operation>Output]
      def call(input, context)
        output = @app.call(input, context)
        output = parse_error(context.response) unless output.is_a?(StandardError)
        output = parse_data(context.response) unless output.is_a?(StandardError)
        output
      end

      private

      def parse_error(response)
        @error_parser.parse(response)
      end

      def parse_data(response)
        @data_parser.parse(response)
      end
    end
  end
end
