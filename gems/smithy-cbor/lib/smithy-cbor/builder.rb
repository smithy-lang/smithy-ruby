# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # @api private
    class Builder
      include Schema::Shapes

      def initialize(options = {})
        @options = options
      end

      def build(shape, data)
        return if shape.target == Prelude::Unit

        Cbor.encode(build_shape(shape, data))
      end

      private

      def build_shape(shape, value)
        case shape.target
        when BlobShape then blob(value)
        when ListShape then list(shape, value)
        when MapShape then map(shape, value)
        when StructureShape then structure(shape, value)
        when UnionShape then union(shape, value)
        else value
        end
      end

      def blob(value)
        value.respond_to?(:read) ? value.read : value
      end

      def list(shape, values)
        return if values.nil?

        values.collect do |value|
          build_shape(shape.target.member, value)
        end
      end

      def map(shape, values)
        return if values.nil?

        values.each.with_object({}) do |(key, value), data|
          data[key] = build_shape(shape.target.value, value)
        end
      end

      def structure(shape, values)
        return if values.nil?

        members = shape.target.members
        values.each_pair.with_object({}) do |(member_name, value), data|
          next if value.nil?

          member_shape = members[member_name]
          next unless member_shape

          data[member_shape.location_name] = build_shape(member_shape, value)
        end
      end

      def union(shape, values) # rubocop:disable Metrics/AbcSize
        return if values.nil?

        data = {}
        if values.is_a?(Schema::Union)
          _name, member_shape = shape.target.member_by_type(values.class)
          data[member_shape.location_name] = build_shape(member_shape, values.value)
        else
          key, value = values.first
          if shape.target.member?(key)
            member_shape = shape.target.member(key)
            data[member_shape.location_name] = build_shape(member_shape, value)
          end
        end
        data
      end
    end
  end
end
