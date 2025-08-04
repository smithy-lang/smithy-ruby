# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # Parser that decodes a CBOR string into a schema.
    class Parser
      include Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      # @param [ShapeRef, Shape] shape
      # @param [String] bytes
      # @param [Object, nil] target (nil)
      # @return [Object, nil]
      def parse(shape, bytes, target = nil)
        return {} if bytes.empty?

        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        shape(ref, Cbor.decode(bytes), target)
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

          target << shape(ref.shape.member, value)
        end
        target
      end

      def map(ref, values, target = nil)
        target = {} if target.nil?
        values.each do |key, value|
          next if value.nil? && !sparse?(ref.shape)

          target[key] = shape(ref.shape.value, value)
        end
        target
      end

      def structure(ref, values, target = nil)
        target = ref.shape.type.new if target.nil?
        ref.shape.members.each do |member_name, member_ref|
          value = values[member_ref.member_name]
          target[member_name] = shape(member_ref, value) unless value.nil?
        end
        target
      end

      def union(ref, values, target = nil) # rubocop:disable Metrics/AbcSize
        ref.shape.members.each do |member_name, member_ref|
          value = values[member_ref.member_name]
          next if value.nil?

          target = ref.shape.member_type(member_name) if target.nil?
          return target.new(member_name => shape(member_ref, value))
        end

        values.delete('__type')
        key, value = values.first
        ref.shape.member_type(:unknown).new(unknown: { key => value })
      end

      def sparse?(shape)
        shape.traits.key?('smithy.api#sparse')
      end
    end
  end
end
