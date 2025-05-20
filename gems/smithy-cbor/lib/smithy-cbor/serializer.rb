# frozen_string_literal: true

require 'base64'

module Smithy
  module CBOR
    # @api private
    class Serializer
      include Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def serialize(shape, data)
        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        return if ref.shape == Prelude::Unit

        CBOR.encode(shape(ref, data))
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
        shape = ref.shape
        values.collect do |value|
          next if value.nil? && !sparse?(shape.traits)

          value.nil? ? nil : shape(shape.member, value)
        end
      end

      def map(ref, values)
        shape = ref.shape
        values.each.with_object({}) do |(key, value), data|
          next if value.nil? && !sparse?(shape.traits)

          data[key] = value.nil? ? nil : shape(shape.value, value)
        end
      end

      def structure(ref, values)
        ref.shape.members.each_with_object({}) do |(member_name, member_ref), data|
          value = values[member_name]
          next if value.nil?

          data[member_ref.member_name] = shape(member_ref, value)
        end
      end

      def union(ref, values) # rubocop:disable Metrics/AbcSize
        data = {}
        if values.is_a?(Schema::Union)
          _name, member_ref = ref.shape.member_by_type(values.class)
          data[member_ref.member_name] = shape(member_ref, values).value
        else
          key, value = values.first
          if ref.shape.member?(key)
            member_ref = ref.shape.member(key)
            data[member_ref.member_name] = shape(member_ref, value)
          end
        end
        data
      end

      def sparse?(traits)
        traits.include?('smithy.api#sparse')
      end
    end
  end
end
