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
        case Schema::Extension.target_shape(shape)
        when Schema::Extension::SHAPE_BLOB then blob(value)
        when Schema::Extension::SHAPE_LIST then list(shape, value)
        when Schema::Extension::SHAPE_MAP then map(shape, value)
        when Schema::Extension::SHAPE_STRUCTURE then structure(shape, value)
        when Schema::Extension::SHAPE_UNION then union(shape, value)
        else value
        end
      end

      def blob(value)
        value.respond_to?(:read) ? value.read : value
      end

      def list(shape, values)
        return if values.nil?

        member, _target_shape, _sparse = Schema::Extension.list_member(shape.target)
        values.collect do |value|
          build_shape(member, value)
        end
      end

      def map(shape, values)
        return if values.nil?

        value_member, _target_shape, _sparse = Schema::Extension.map_value_member(shape.target)
        values.each.with_object({}) do |(key, value), data|
          data[key] = build_shape(value_member, value)
        end
      end

      def structure(shape, values)
        return if values.nil?

        index = Schema::Extension.member_index(shape.target)
        values.each_pair.with_object({}) do |(member_name, value), data|
          next if value.nil?
          next unless (entry = index[member_name])

          wire_name, member_shape, _target_shape = entry
          data[wire_name] = build_shape(member_shape, value)
        end
      end

      def union(shape, values)
        return if values.nil?

        key, value =
          if values.is_a?(Schema::Union)
            member_name, _member_shape = shape.target.member_by_type(values.class)
            [member_name, values.value]
          else
            values.first
          end
        entry = Schema::Extension.member_index(shape.target)[key]
        return {} unless entry

        wire_name, member_shape, _target_shape = entry
        { wire_name => build_shape(member_shape, value) }
      end
    end
  end
end
