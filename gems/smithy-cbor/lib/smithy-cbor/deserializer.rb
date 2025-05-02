# frozen_string_literal: true

require 'base64'

module Smithy
  module CBOR
    # @api private
    class Deserializer
      include Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def deserialize(shape, bytes, target)
        return {} if bytes.empty?

        shape(shape, CBOR.decode(bytes), target)
      end

      private

      def shape(shape, value, target = nil)
        return nil if value.nil?

        case shape
        when ListShape then list(shape, value, target)
        when MapShape then map(shape, value, target)
        when StructureShape then structure(shape, value, target)
        when UnionShape then union(shape, value, target)
        else value
        end
      end

      def list(shape, values, target = nil)
        target = [] if target.nil?
        values.each do |value|
          next if value.nil? && !sparse?(shape)

          target << (value.nil? ? nil : shape(shape.member.shape, value))
        end
        target
      end

      def map(shape, values, target = nil)
        target = {} if target.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(shape)

          target[key] = value.nil? ? nil : shape(shape.value.shape, value)
        end
        target
      end

      def structure(shape, values, target = nil)
        return Schema::EmptyStructure.new if shape == Prelude::Unit

        target = shape.type.new if target.nil?
        shape.members.each do |member_name, member_shape|
          key = member_shape.name
          next unless values.key?(key)

          target[member_name] = shape(member_shape.shape, values[key])
        end
        target
      end

      def union(shape, values, target = nil) # rubocop:disable Metrics/AbcSize
        raise ArgumentError, "union value includes more than one key, received: #{values.keys}" if values.size > 1

        key, value = values.first
        return nil if key.nil?

        shape.members.each do |member_name, member_shape|
          name = member_shape.name
          next unless values.key?(name)

          target = shape.member_type(member_name) if target.nil?
          return target.new(shape(member_shape.shape, values[name]))
        end
        shape.member_type(:unknown).new(key, value)
      end

      def sparse?(shape)
        shape.traits.include?('smithy.api#sparse')
      end
    end
  end
end
