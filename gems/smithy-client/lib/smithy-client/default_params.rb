# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Client
    # @api private
    class DefaultParams
      include Schema::Shapes

      def initialize(ref)
        @ref = ref
      end

      # @param [Hash] params
      # @return [Hash]
      def apply(params)
        structure(@ref, params)
      end

      private

      def shape(ref, value)
        case ref.shape
        when ListShape then list(ref, value)
        when MapShape then map(ref, value)
        when StructureShape then structure(ref, value)
        else value
        end
      end

      def list(ref, values)
        return if values.nil?

        shape = ref.shape
        values.each do |value|
          shape(shape.member, value)
        end
        values
      end

      def map(ref, values)
        return if values.nil?

        shape = ref.shape
        values.each_pair do |_key, value|
          shape(shape.value, value)
        end
        values
      end

      def structure(ref, values)
        return if values.nil?

        ref.shape.members.each do |member_name, member_ref|
          value = values[member_name]
          value ||= member_ref.default_value if default?(ref, member_ref)
          next if value.nil? && !default?(ref, member_ref) # default can have nil values for documents

          values[member_name] = shape(member_ref, value)
        end
        values
      end

      def default?(ref, member_ref)
        # skip defaults for top level members
        return false if ref == @ref

        member_ref.default? && !member_ref.client_optional?
      end
    end
  end
end
