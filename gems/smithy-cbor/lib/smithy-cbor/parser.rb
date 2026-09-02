# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # @api private
    class Parser
      include Schema::Shapes

      def initialize(_options = {})
        @extension = Smithy::Schema::Extension
      end

      def parse(shape, bytes, result = nil)
        return {} if bytes.empty?

        parse_shape(shape, Cbor.decode(bytes), result)
      end

      private

      def parse_shape(shape, value, result = nil)
        return nil if value.nil?

        target = shape.target
        case target
        when ListShape then list(shape, value, result)
        when MapShape then map(shape, value, result)
        when StructureShape then structure(shape, value, result)
        when UnionShape then union(shape, value, result)
        else value
        end
      end

      def list(shape, values, result = nil)
        target = shape.target
        sparse = Smithy::Schema::Extension.sparse?(target)
        list_member = target.member
        result = [] if result.nil?
        values.each do |value|
          next if value.nil? && !sparse

          result << parse_shape(list_member, value)
        end
        result
      end

      def map(shape, values, result = nil)
        target = shape.target
        sparse = Smithy::Schema::Extension.sparse?(target)
        value_member = target.value
        result = {} if result.nil?
        values.each do |key, value|
          next if value.nil? && !sparse

          result[key] = parse_shape(value_member, value)
        end
        result
      end

      def structure(shape, values, result = nil)
        target = shape.target
        result = target.type.new if result.nil?
        index = @extension.wire_index(target)
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
        target = shape.target
        index = @extension.wire_index(target)
        values.each do |wire_name, value|
          next if value.nil?

          entry = index[wire_name]
          next unless entry

          member_name, member_shape = entry
          result = target.member_type(member_name) if result.nil?
          return result.new(member_name => parse_shape(member_shape, value))
        end

        values.delete('__type')
        key, value = values.first
        target.member_type(:unknown).new(unknown: { key => value })
      end
    end
  end
end
