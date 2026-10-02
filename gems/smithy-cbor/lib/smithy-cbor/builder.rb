# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # @api private
    class Builder
      def initialize(_options = {}); end

      def build(shape, data)
        return if shape.target == Schema::Shapes::Prelude::Unit

        Cbor.encode(build_shape(shape, data))
      end

      private

      def build_shape(shape, value)
        target = shape.target
        case target
        when Schema::Shapes::BlobShape then blob(value)
        when Schema::Shapes::ListShape then list(shape, value)
        when Schema::Shapes::MapShape then map(shape, value)
        when Schema::Shapes::StructureShape then structure(shape, value)
        when Schema::Shapes::UnionShape then union(shape, value)
        else value
        end
      end

      def blob(value)
        value.respond_to?(:read) ? value.read : value
      end

      def list(shape, values)
        return if values.nil?

        member = shape.target.member
        values.collect do |value|
          build_shape(member, value)
        end
      end

      def map(shape, values)
        return if values.nil?

        value_member = shape.target.value
        data = {}
        values.each do |key, value|
          data[key] = build_shape(value_member, value)
        end
        data
      end

      def structure(shape, values)
        return if values.nil?

        target = shape.target
        data = {}
        values.each_pair do |member_name, value|
          next if value.nil?
          next unless (member_shape = target.member(member_name))

          data[member_shape.name] = build_shape(member_shape, value)
        end
        data
      end

      def union(shape, values)
        return if values.nil?

        key, value =
          if values.is_a?(Schema::Union)
            [values.member, values.value]
          else
            values.first
          end
        member_shape = shape.target.member(key)
        return {} unless member_shape

        { member_shape.name => build_shape(member_shape, value) }
      end
    end
  end
end
