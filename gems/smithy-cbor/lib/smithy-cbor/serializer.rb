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
        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(target: shape)
        return nil if ref.target == Prelude::Unit

        CBOR.encode(shape(ref, data))
      end

      private

      def shape(ref, value)
        case ref.target
        when BlobShape then blob(value)
        when ListShape then list(ref, value)
        when MapShape then map(ref, value)
        when StructureShape then structure(ref, value)
        when UnionShape then union(ref, value)
        else value
        end
      end

      def blob(value)
        value.is_a?(String) ? value : value.read
      end

      def list(ref, values)
        values.collect do |value|
          next if value.nil? && !sparse?(ref.target)

          value.nil? ? nil : shape(ref.target.member, value)
        end
      end

      def map(ref, values)
        values.each.with_object({}) do |(key, value), data|
          next if value.nil? && !sparse?(ref.target)

          data[key] = value.nil? ? nil : shape(ref.target.value, value)
        end
      end

      def structure(ref, values)
        values.each_pair.with_object({}) do |(key, value), data|
          if ref.target.member?(key) && !value.nil?
            member_ref = ref.target.member(key)
            data[member_ref.location] = shape(member_ref, value)
          end
        end
      end

      def union(ref, values)
        data = {}
        if values.is_a?(Schema::Union)
          member_ref = ref.target.member_by_type(values.class)
          data[member_ref.location] = shape(member_ref, values).value
        else
          key, value = values.first
          if ref.target.member?(key)
            member_ref = ref.target.member(key)
            data[member_ref.location] = shape(member_ref, value)
          end
        end
        data
      end

      def sparse?(shape)
        shape.traits.include?('smithy.api#sparse')
      end
    end
  end
end
