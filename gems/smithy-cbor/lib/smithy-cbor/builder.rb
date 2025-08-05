# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # Builder that encodes a schema into a CBOR string.
    class Builder
      include Schema::Shapes

      # @param [ShapeRef, Shape] shape
      def initialize(shape, options = {})
        @ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        @options = options
      end

      # @param [Object] data
      # @return [String, nil]
      def build(data)
        return if @ref.shape == Prelude::Unit

        Cbor.encode(shape(@ref, data))
      end

      private

      def shape(ref, value)
        case ref.shape
        when BlobShape then blob(value)
        when ListShape then list(ref, value)
        when MapShape then map(ref, value)
        when StructureShape then structure(ref, value)
        when UnionShape then union(ref, value)
        else value
        end
      end

      def blob(value)
        value.respond_to?(:read) ? value.read : value
      end

      def list(ref, values)
        return if values.nil?

        shape = ref.shape
        values.collect do |value|
          shape(shape.member, value)
        end
      end

      def map(ref, values)
        return if values.nil?

        shape = ref.shape
        values.each.with_object({}) do |(key, value), data|
          data[key] = shape(shape.value, value)
        end
      end

      def structure(ref, values)
        return if values.nil?

        ref.shape.members.each_with_object({}) do |(member_name, member_ref), data|
          value = values[member_name]
          next if value.nil?

          data[member_ref.member_name] = shape(member_ref, value)
        end
      end

      def union(ref, values) # rubocop:disable Metrics/AbcSize
        return if values.nil?

        data = {}
        if values.is_a?(Schema::Union)
          _name, member_ref = ref.shape.member_by_type(values.class)
          data[member_ref.member_name] = shape(member_ref, values.value)
        else
          key, value = values.first
          if ref.shape.member?(key)
            member_ref = ref.shape.member(key)
            data[member_ref.member_name] = shape(member_ref, value)
          end
        end
        data
      end
    end
  end
end
