# frozen_string_literal: true

require 'base64'
require 'time'

module Smithy
  module Client
    # @api private
    class DefaultParams
      include Schema::Shapes

      def initialize(shape)
        @shape = shape
      end

      # @param [Hash] params
      # @return [Hash]
      def apply(params)
        structure(@shape, params)
      end

      private

      def apply_shape(shape, value)
        case shape.target
        when ListShape then list(shape, value)
        when MapShape then map(shape, value)
        when StructureShape then structure(shape, value)
        else value
        end
      end

      def list(shape, values)
        return if values.nil?

        member = shape.target.member
        values.each do |value|
          apply_shape(member, value)
        end
        values
      end

      def map(shape, values)
        return if values.nil?

        value_shape = shape.target.value
        values.each_pair do |_key, value|
          apply_shape(value_shape, value)
        end
        values
      end

      def structure(shape, values)
        return if values.nil?

        shape.target.members.each do |member_name, member_shape|
          value = values[member_name]
          value ||= default(member_shape) if default?(shape, member_shape.traits)
          next if value.nil? && !default?(shape, member_shape.traits) # default can have nil values

          values[member_name] = apply_shape(member_shape, value)
        end
        values
      end

      def default?(shape, traits)
        # skip defaults for top level members
        return false if shape == @shape

        traits.include?('smithy.api#default') && !traits.include?('smithy.api#clientOptional')
      end

      def default(member_shape)
        default = member_shape.traits['smithy.api#default']
        case member_shape.target
        when BlobShape then Base64.strict_decode64(default)
        when TimestampShape then timestamp_default(default)
        else default
        end
      end

      def timestamp_default(default)
        case default
        when String then Time.parse(default)
        when Integer then Time.at(default)
        else raise ArgumentError, "Invalid default value for Timestamp: #{default.inspect}"
        end
      end
    end
  end
end
