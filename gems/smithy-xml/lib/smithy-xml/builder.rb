# frozen_string_literal: true

require 'base64'

module Smithy
  module Xml
    # @api private
    class Builder
      def initialize(options = {})
        @indent = options.fetch(:indent, '')
        @pad = options.fetch(:pad, '')
        @default_timestamp = options.fetch(:default_timestamp, 'date-time')
        @map_entry_shape = Schema::Shapes::MemberShape.new(target: Schema::Shapes::MapShape.new)
      end

      def build(shape, data, output = nil)
        output ||= []
        @builder = DocBuilder.new(output: output, indent: @indent, pad: @pad)
        structure(Extension.structure_name(shape), shape, data)
        output.join
      end

      private

      def build_shape(name, shape, value)
        case Schema::Extension.target_shape(shape)
        when Schema::Extension::SHAPE_BLOB then node(name, shape, blob(value))
        when Schema::Extension::SHAPE_LIST then list(name, shape, value)
        when Schema::Extension::SHAPE_MAP then map(name, shape, value)
        when Schema::Extension::SHAPE_STRUCTURE then structure(name, shape, value)
        when Schema::Extension::SHAPE_TIMESTAMP then node(name, shape, timestamp(shape, value))
        when Schema::Extension::SHAPE_UNION then union(name, shape, value)
        else node(name, shape, value.to_s)
        end
      end

      def blob(value)
        Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
      end

      def list(name, shape, values)
        member_shape, = Schema::Extension.list_member(shape.target)
        if Extension.flattened?(shape)
          values.each do |value|
            build_shape(name, member_shape, value)
          end
        else
          node(name, shape) do
            values.each do |value|
              build_shape(Extension.wire_name(member_shape), member_shape, value)
            end
          end
        end
      end

      def map(name, shape, values)
        if Extension.flattened?(shape)
          flat_map_entries(name, shape, values)
        else
          key_name, key_shape, value_name, value_shape = Extension.map_parts(shape)
          node(name, shape) do
            values.each do |key, value|
              node('entry', @map_entry_shape) do
                build_shape(key_name, key_shape, key)
                build_shape(value_name, value_shape, value)
              end
            end
          end
        end
      end

      def flat_map_entries(name, shape, values)
        key_name, key_shape, value_name, value_shape = Extension.map_parts(shape)
        values.each do |key, value|
          node(name, shape) do
            build_shape(key_name, key_shape, key)
            build_shape(value_name, value_shape, value)
          end
        end
      end

      def structure(name, shape, values)
        return node(name, shape) if values.empty?

        node(name, shape, structure_attrs(shape, values)) do
          Extension.element_members(shape.target).each do |ruby_member_name, xml_name, member_shape|
            next if values[ruby_member_name].nil?

            build_shape(xml_name, member_shape, values[ruby_member_name])
          end
        end
      end

      def structure_attrs(shape, values)
        members = Extension.attribute_members(shape.target)
        members.each_with_object({}) do |(ruby_member_name, xml_name, _member_shape), attrs|
          next unless values.key?(ruby_member_name)

          attrs[xml_name] = values[ruby_member_name]
        end
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

      def union(name, shape, values) # rubocop:disable Metrics/AbcSize
        return node(name, shape) if values.empty?

        node(name, shape, structure_attrs(shape, values)) do
          if values.is_a?(Schema::Union)
            member_name, _member_shape = shape.target.member_by_type(values.class)
            member_shape = shape.target.member(member_name)
            build_shape(Extension.wire_name(member_shape), member_shape, values.value)
          else
            key, value = values.first
            if shape.target.member?(key)
              member_shape = shape.target.member(key)
              build_shape(Extension.wire_name(member_shape), member_shape, value)
            end
          end
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
      def node(name, shape, *args, &)
        attrs = args.last.is_a?(Hash) ? args.pop : {}
        namespace_attrs = Extension.namespace_attrs(shape)
        attrs = attrs.empty? ? namespace_attrs : namespace_attrs.merge(attrs) if namespace_attrs
        args << attrs
        @builder.node(name, *args, &)
      end
    end
  end
end
