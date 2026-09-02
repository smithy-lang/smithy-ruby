# frozen_string_literal: true

require 'base64'

module Smithy
  module Cbor
    # @api private
    class Builder
      include Schema::Shapes

      def initialize(_options = {})
        @extension = Smithy::Schema::Extension
      end

      def build(shape, data)
        return if shape.target == Prelude::Unit

        Cbor.encode(build_shape(shape, data))
      end

      private

      def build_shape(shape, value)
        target = shape.target
        case target
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

        member = shape.target.member
        values.collect do |value|
          build_shape(member, value)
        end
      end

      def map(shape, values)
        return if values.nil?

        value_member = shape.target.value
        values.each.with_object({}) do |(key, value), data|
          data[key] = build_shape(value_member, value)
        end
      end

      def structure(shape, values)
        return if values.nil?

        index = @extension.member_index(shape.target)
        values.each_pair.with_object({}) do |(member_name, value), data|
          next if value.nil?

          entry = index[member_name]
          next unless entry

          wire_name, member_shape = entry
          data[wire_name] = build_shape(member_shape, value)
        end
      end

      def union(shape, values)
        return if values.nil?

        target = shape.target
        key, value =
          if values.is_a?(Schema::Union)
            values.active_member_value
          else
            values.first
          end

        return {} unless key

        entry = @extension.member_index(target)[key]
        return {} unless entry

        wire_name, member_shape = entry
        { wire_name => build_shape(member_shape, value) }
      end
    end
  end
end
