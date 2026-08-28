# frozen_string_literal: true

require 'base64'

module Smithy
  module Xml
    # @api private
    class Builder
      include Smithy::Schema::Shapes

      def initialize(options = {})
        @indent = options.fetch(:indent, '')
        @pad = options.fetch(:pad, '')
        @extension = Smithy::Xml::Extension
      end

      def build(shape, data, output = nil)
        output ||= []
        @builder = DocBuilder.new(output: output, indent: @indent, pad: @pad)
        structure(@extension.structure_name(shape), shape, data)
        output.join
      end

      private

      def build_shape(name, shape, value)
        case shape.target
        when BlobShape then node(name, shape, blob(value))
        when ListShape then list(name, shape, value)
        when MapShape then map(name, shape, value)
        when StructureShape then structure(name, shape, value)
        when TimestampShape then node(name, shape, timestamp(shape, value))
        when UnionShape then union(name, shape, value)
        else node(name, shape, value.to_s)
        end
      end

      def blob(value)
        Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
      end

      def list(name, shape, values)
        member_shape = shape.target.member
        if flat?(shape)
          values.each do |value|
            build_shape(name, member_shape, value)
          end
        else
          node(name, shape) do
            values.each do |value|
              build_shape(@extension.wire_name(member_shape), shape.target.member, value)
            end
          end
        end
      end

      def map(name, shape, values)
        key_shape = shape.target.key
        value_shape = shape.target.value
        if flat?(shape)
          flat_map_entries(name, shape, values, key_shape, value_shape)
        else
          node(name, shape) do
            values.each do |key, value|
              node('entry', MemberShape.new(target: MapShape.new)) do
                build_shape(@extension.wire_name(key_shape), key_shape, key)
                build_shape(@extension.wire_name(value_shape), value_shape, value)
              end
            end
          end
        end
      end

      def flat_map_entries(name, shape, values, key_shape, value_shape)
        values.each do |key, value|
          node(name, shape) do
            build_shape(@extension.wire_name(key_shape), key_shape, key)
            build_shape(@extension.wire_name(value_shape), value_shape, value)
          end
        end
      end

      def structure(name, shape, values)
        return node(name, shape) if values.empty?

        node(name, shape, structure_attrs(shape, values)) do
          @extension.members(shape.target)[:elements].each do |ruby_member_name, member_shape|
            next if values[ruby_member_name].nil?

            build_shape(
              @extension.wire_name(member_shape),
              member_shape,
              values[ruby_member_name]
            )
          end
        end
      end

      def structure_attrs(shape, values)
        @extension.members(shape.target)[:attributes].each_with_object({}) do |(ruby_member_name, member_shape), attrs|
          next unless values.key?(ruby_member_name)

          attrs[@extension.wire_name(member_shape)] = values[ruby_member_name]
        end
      end

      def timestamp(shape, value)
        trait = 'smithy.api#timestampFormat'
        case shape.traits[trait] || shape.target.traits[trait]
        when 'epoch-seconds' then value.to_i.to_s
        when 'http-date' then value.utc.httpdate
        else
          # default to date-time
          value.utc.iso8601
        end
      end

      def union(name, shape, values)
        return node(name, shape) if values.empty?

        values = values.to_h if values.is_a?(Schema::Union)
        node(name, shape, structure_attrs(shape, values)) do
          key, value = values.first
          if shape.target.member?(key)
            member_shape = shape.target.member(key)
            build_shape(@extension.wire_name(member_shape), member_shape, value)
          end
        end
      end

      def flat?(shape)
        shape.traits.key?('smithy.api#xmlFlattened')
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
        attrs = @extension.namespace_attrs(shape).merge(attrs)
        args << attrs
        @builder.node(name, *args, &)
      end
    end
  end
end
