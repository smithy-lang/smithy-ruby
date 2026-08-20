# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # @api private
    class Parser
      include Schema::Shapes

      def initialize(_options = {})
        @extension = Schema::Extension
      end

      def parse(shape, bytes, result = nil)
        return {} if bytes.empty?

        parse_shape(shape, Cbor.decode(bytes), result)
      end

      private

      def parse_shape(shape, value, result = nil)
        return nil if value.nil?

        case shape.target
        when ListShape then list(shape, value, result)
        when MapShape then map(shape, value, result)
        when StructureShape then structure(shape, value, result)
        when UnionShape then union(shape, value, result)
        else value
        end
      end

      def list(shape, values, result = nil)
        result = [] if result.nil?
        values.each do |value|
          next if value.nil? && !sparse?(shape.target)

          result << parse_shape(shape.target.member, value)
        end
        result
      end

      def map(shape, values, result = nil)
        result = {} if result.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(shape.target)

          result[key] = parse_shape(shape.target.value, value)
        end
        result
      end

      def structure(shape, values, result = nil)
        result = shape.target.type.new if result.nil?
        index = @extension.member_index(shape.target)
        values.each do |wire_name, value|
          next if value.nil?

          entry = index[wire_name]
          next unless entry

          member_name, member_shape = entry
          result[member_name] = parse_shape(member_shape, value)
        end
        result
      end

      def union(shape, values, result = nil) # rubocop:disable Metrics/AbcSize
        index = @extension.member_index(shape.target)
        values.each do |wire_name, value|
          next if value.nil?

          entry = index[wire_name]
          next unless entry

          member_name, member_shape = entry
          result = shape.target.member_type(member_name) if result.nil?
          return result.new(member_name => parse_shape(member_shape, value))
        end

        values.delete('__type')
        key, value = values.first
        shape.target.member_type(:unknown).new(unknown: { key => value })
      end

      def sparse?(shape)
        shape.traits.key?(:sparse)
      end
    end
  end
end
