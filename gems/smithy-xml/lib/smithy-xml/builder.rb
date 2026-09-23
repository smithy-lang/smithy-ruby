# frozen_string_literal: true

require 'base64'

module Smithy
  module Xml
    # @api private
    class Builder
      MAP_ENTRY_SHAPE = Schema::Shapes::MemberShape.new(
        target: Schema::Shapes::MapShape.new
      ).freeze

      def initialize(options = {})
        @indent = options.fetch(:indent, '')
        @pad = options.fetch(:pad, '')
        @default_timestamp = options.fetch(:default_timestamp, 'date-time')
      end

      def build(shape, data, output = nil)
        output ||= []
        builder = DocBuilder.new(output: output, indent: @indent, pad: @pad)
        structure(builder, Extension.structure_name(shape), shape, data)
        output.join
      end

      private

      def build_shape(builder, name, shape, value)
        target_shape = shape.target
        case target_shape
        when Schema::Shapes::BlobShape then node(builder, name, shape, blob(value))
        when Schema::Shapes::ListShape then list(builder, name, shape, value)
        when Schema::Shapes::MapShape then map(builder, name, shape, value)
        when Schema::Shapes::StructureShape then structure(builder, name, shape, value)
        when Schema::Shapes::TimestampShape then node(builder, name, shape, timestamp(shape, value))
        when Schema::Shapes::UnionShape then union(builder, name, shape, value)
        else node(builder, name, shape, value.to_s)
        end
      end

      def blob(value)
        Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
      end

      def list(builder, name, shape, values)
        member_shape = shape.target.member
        flattened = Extension.flattened?(shape)
        if flattened
          values.each do |value|
            build_shape(builder, name, member_shape, value)
          end
        else
          member_name = Extension.wire_name(member_shape)
          node(builder, name, shape) do
            values.each do |value|
              build_shape(builder, member_name, member_shape, value)
            end
          end
        end
      end

      def map(builder, name, shape, values)
        flattened = Extension.flattened?(shape)
        if flattened
          flat_map_entries(builder, name, shape, values)
        else
          key_name, key_member, value_name, value_member = Extension.map_parts(shape)
          node(builder, name, shape) do
            values.each do |key, value|
              node(builder, 'entry', MAP_ENTRY_SHAPE) do
                build_shape(builder, key_name, key_member, key)
                build_shape(builder, value_name, value_member, value)
              end
            end
          end
        end
      end

      def flat_map_entries(builder, name, shape, values)
        key_name, key_member, value_name, value_member = Extension.map_parts(shape)
        values.each do |key, value|
          node(builder, name, shape) do
            build_shape(builder, key_name, key_member, key)
            build_shape(builder, value_name, value_member, value)
          end
        end
      end

      def structure(builder, name, shape, values)
        return node(builder, name, shape) if values.empty?

        node(builder, name, shape, structure_attrs(shape, values)) do
          element_members = Extension.element_members(shape.target)
          element_members.each do |member_name, xml_name, member_shape|
            member_value = values[member_name]
            next if member_value.nil?

            build_shape(builder, xml_name, member_shape, member_value)
          end
        end
      end

      def structure_attrs(shape, values)
        attribute_members = Extension.attribute_members(shape.target)
        attrs = {}
        attribute_members.each do |name, xml_name, _member_shape|
          value = values[name]
          next if value.nil? && !values.key?(name)

          attrs[xml_name] = value
        end
        attrs
      end

      def timestamp(shape, value)
        format = Extension.timestamp_format(shape)
        format = @default_timestamp if format == :default
        case format
        when 'epoch-seconds' then value.to_i.to_s
        when 'http-date' then value.utc.httpdate
        when 'date-time' then value.utc.iso8601
        else raise ArgumentError, "unsupported XML timestamp format: #{format.inspect}"
        end
      end

      def union(builder, name, shape, values)
        return node(builder, name, shape) if values.empty?

        if values.is_a?(Schema::Union)
          key = values.member
          value = values.value
        else
          key, value = values.first
        end
        node(builder, name, shape, structure_attrs(shape, values)) do
          member_shape = shape.target.member(key)
          build_shape(builder, Extension.wire_name(member_shape), member_shape, value) if member_shape
        end
      end

      # The `args` list may contain:
      #
      #   * [] - empty, no value or attributes
      #   * [value] - inline element, no attributes
      #   * [value, attributes_hash] - inline element with attributes
      #   * [attributes_hash] - self closing element with attributes
      #
      # Pass a block if you want to nest XML nodes inside.  When doing this,
      # you may *not* pass a value to the `args` list.
      #
      def node(builder, name, shape, *args, &)
        attrs = args.last.is_a?(Hash) ? args.pop : {}
        namespace_attrs = Extension.namespace_attrs(shape)
        if namespace_attrs
          attrs = attrs.empty? ? namespace_attrs : namespace_attrs.merge(attrs)
        end
        args << attrs
        builder.node(name, *args, &)
      end
    end
  end
end
