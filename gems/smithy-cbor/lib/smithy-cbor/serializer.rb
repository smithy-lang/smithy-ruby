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
        return nil if shape == Prelude::Unit

        CBOR.encode(shape(shape, data))
      end

      private

      def shape(shape, value)
        case shape
        when BlobShape then blob(value)
        when ListShape then list(shape, value)
        when MapShape then map(shape, value)
        when StructureShape then structure(shape, value)
        when UnionShape then union(shape, value)
        else value
        end
      end

      def blob(value)
        value.is_a?(String) ? value : value.read
      end

      def list(shape, values)
        values.collect do |value|
          next if value.nil? && !sparse?(shape)

          if value.nil? && sparse?(shape)
            nil
          else
            shape(shape.member.shape, value)
          end
        end
      end

      def map(shape, values)
        values.each.with_object({}) do |(key, value), data|
          next if value.nil? && !sparse?(shape)

          data[key] =
            if value.nil? && sparse?(shape)
              nil
            else
              shape(shape.value.shape, value)
            end
        end
      end

      def structure(shape, values)
        values.each_pair.with_object({}) do |(key, value), data|
          if shape.member?(key) && !value.nil?
            member_shape = shape.member(key)
            data[member_shape.name] = shape(member_shape.shape, value)
          end
        end
      end

      def union(shape, values)
        data = {}
        if values.is_a?(Schema::Union)
          member_shape = shape.member_by_type(values.class)
          data[member_shape.name] = shape(member_shape.shape, values).value
        else
          key, value = values.first
          if shape.member?(key)
            member_shape = shape.member(key)
            data[member_shape.name] = shape(member_shape.shape, value)
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
