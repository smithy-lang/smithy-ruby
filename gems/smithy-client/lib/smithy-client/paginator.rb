# frozen_string_literal: true

module Smithy
  module Client
    # @api private
    class Paginator
      def initialize(options = {})
        @input_token = options[:input_token]
        @output_token = options[:output_token]
        @items = options[:items]
        @page_size = options[:page_size]
      end

      # @return [String, nil]
      attr_reader :page_size

      # @param [Output]
      # @return [Hash]
      def next_tokens(output)
        output_shape = output.context.operation.output
        data = output.data
        @output_token.split('.').each do |member|
          member_name = output_shape.name_by_member_name(member)
          output_shape = output_shape.member(member_name).shape
          data = data[member_name]
        end

        next_tokens = {}
        res = next_tokens
        input_shape = output.context.operation.input
        @input_token.split('.').each do |member|
          member_name = input_shape.name_by_member_name(member)
          input_shape = input_shape.member(member_name).shape
          next_tokens ||= {}
          next_tokens[member_name] = data unless empty_value?(data)
        end
        res
      end

      # @param [Output] output
      # @return [Boolean]
      def truncated?(output)
        next_t = next_tokens(output)
        prev_t = prev_tokens(output)
        !(next_t.empty? || next_t == prev_t)
      end

      def prev_tokens(output)
        input_shape = output.context.operation.input
        params = output.context.params
        prev_tokens = {}
        @input_token.split('.').each do |member|
          member_name = input_shape.name_by_member_name(member)
          input_shape = input_shape.member(member_name).shape
          prev_tokens ||= {}
          prev_tokens[member_name] = params unless empty_value?(params[member_name])
        end
        params
      end

      def items(output)
        output_shape = output.context.operation.output
        data = output.data
        @items.split('.').each do |member|
          member_name = output_shape.name_by_member_name(member)
          output_shape = output_shape.member(member_name).shape
          data = data[member_name]
        end
        data
      end

      private

      def empty_value?(value)
        value.nil? || value == '' || value == [] || value == {}
      end
    end
  end
end
