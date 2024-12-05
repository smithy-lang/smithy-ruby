# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    class Operation
      def initialize
        @errors = []
        yield self if block_given?
      end

      # @return [String, nil]
      attr_accessor :name

      # @return [Shape, nil]
      attr_accessor :input

      # @return [Shape, nil]
      attr_accessor :output

      # @return [Array<Shape>]
      attr_accessor :errors
    end
  end
end
