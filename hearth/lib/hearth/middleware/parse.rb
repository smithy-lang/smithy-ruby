# frozen_string_literal: true

module Hearth
  module Middleware
    # A middleware that parses a response object.
    # @api private
    class Parse
      # @param [Class] app The next middleware in the stack.
      # @param [Class] error_parser A parser object responsible for parsing the
      #  response if there is an error. It must respond to #parse and take the
      #  response as an argument.
      # @param [Class] data_parser A parser object responsible for parsing the
      #  response if there is data. It must respond to #parse and take the
      #  response as an argument.
      def initialize(app, error_parser:, data_parser:, interceptors:)
        @app = app
        @error_parser = error_parser
        @data_parser = data_parser
        @interceptors = interceptors
      end

      # @param input
      # @param context
      # @return [Output]
      def call(input, context)
        output = @app.call(input, context)

        # modify_before_deserialization hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeAttemptCompletion
        @interceptors.reverse.each do |i|
          if i.respond_to?(:modify_before_deserialization)
            begin
              context.request = i.modify_before_deserialization(context.interceptor_context(input, output))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        # read_before_deserialization hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeAttemptCompletion
        @interceptors.reverse.each do |i|
          if i.respond_to?(:read_before_deserialization)
            begin
              i.read_before_deserialization(context.interceptor_context(input, output))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        parse_error(context, output) unless output.error
        parse_data(context, output) unless output.error

        # read_after_deserialization hook
        # exception behavior - exceptions set to output.error and control
        # bubbles up to modifyBeforeAttemptCompletion
        @interceptors.reverse.each do |i|
          if i.respond_to?(:read_after_deserialization)
            begin
              i.read_after_deserialization(context.interceptor_context(input, output))
            rescue StandardError => e
              return Hearth::Output.new(error: e)
            end
          end
        end

        output
      end

      private

      def parse_error(context, output)
        output.error = @error_parser.parse(context.response, output.metadata)
      end

      def parse_data(context, output)
        output.data = @data_parser.parse(context.response)
      end
    end
  end
end
