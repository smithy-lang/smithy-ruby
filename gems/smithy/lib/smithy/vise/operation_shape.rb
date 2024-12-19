# frozen_string_literal: true

module Smithy
  module Vise
    # Represents an operation shape from the model.
    class OperationShape < Shape
      # (see Shape#initialize)
      def initialize(id, shape)
        super
        @input = shape['input']
        @output = shape['output']
        @errors = shape['errors']
      end

      # @return [Hash<String, String>, nil]
      attr_reader :input

      # @return [Hash<String, String>, nil]
      attr_reader :output

      # @return [Array<Hash<String, String>>, nil]
      attr_reader :errors
    end
  end
end
