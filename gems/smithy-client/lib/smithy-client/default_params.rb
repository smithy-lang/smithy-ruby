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
        target = shape.target
        case target
        when ListShape then list(shape, value)
        when MapShape then map(shape, value)
        when StructureShape then structure(shape, value)
        else value
        end
      end

      def list(shape, values)
        return if values.nil?

        target = shape.target
        member = target.member
        values.each do |value|
          apply_shape(member, value)
        end
        values
      end

      def map(shape, values)
        return if values.nil?

        target = shape.target
        value_shape = target.value
        values.each_pair do |_key, value|
          apply_shape(value_shape, value)
        end
        values
      end

      def structure(shape, values)
        return if values.nil?

        target = shape.target
        unless shape == @shape
          Schema::Extension.default_members(target).each do |member_name, member_shape|
            next unless values[member_name].nil?

            values[member_name] = default(member_shape)
          end
        end

        values.each do |member_name, value|
          member_shape = target.members[member_name]
          next unless member_shape

          values[member_name] = apply_shape(member_shape, value)
        end
        values
      end

      def default(member_shape)
        default = Schema::Extension.default_trait(member_shape)
        target = member_shape.target
        case target
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
