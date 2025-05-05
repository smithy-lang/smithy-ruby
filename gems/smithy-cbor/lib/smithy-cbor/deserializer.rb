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

        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        shape(ref, CBOR.decode(bytes), target)
      end

      private

      def shape(ref, value, target = nil)
        return nil if value.nil?

        case ref.shape
        when ListShape then list(ref, value, target)
        when MapShape then map(ref, value, target)
        when StructureShape then structure(ref, value, target)
        when UnionShape then union(ref, value, target)
        else value
        end
      end

      def list(ref, values, target = nil)
        target = [] if target.nil?
        values.each do |value|
          next if value.nil? && !sparse?(ref.shape)

          target << (value.nil? ? nil : shape(ref.shape.member, value))
        end
        target
      end

      def map(ref, values, target = nil)
        target = {} if target.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(ref.shape)

          target[key] = value.nil? ? nil : shape(ref.shape.value, value)
        end
        target
      end

      def structure(ref, values, target = nil)
        return Schema::EmptyStructure.new if ref.shape == Prelude::Unit

        target = ref.shape.type.new if target.nil?
        ref.shape.members.each do |member_name, member_ref|
          key = member_ref.location_name
          next unless values.key?(key)

          target[member_name] = shape(member_ref, values[key])
        end
        target
      end

      def union(ref, values, target = nil) # rubocop:disable Metrics/AbcSize
        raise ArgumentError, "union value includes more than one key, received: #{values.keys}" if values.size > 1

        key, value = values.first
        return nil if key.nil?

        ref.shape.members.each do |member_name, member_ref|
          name = member_ref.location_name
          next unless values.key?(name)

          target = ref.shape.member_type(member_name) if target.nil?
          return target.new(shape(member_ref, values[name]))
        end
        ref.shape.member_type(:unknown).new(key, value)
      end

      def sparse?(shape)
        shape.traits.include?('smithy.api#sparse')
      end
    end
  end
end
