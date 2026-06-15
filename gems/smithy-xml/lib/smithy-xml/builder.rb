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
      end

      def build(shape, data, output = nil)
        output ||= []
        @builder = DocBuilder.new(output: output, indent: @indent, pad: @pad)
        xml_name = shape.traits['smithy.api#xmlName'] || shape.target.traits['smithy.api#xmlName'] || shape.target.name
        structure(xml_name, shape, data)
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
              build_shape(location_name(member_shape, 'member'), shape.target.member, value)
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
                build_shape(location_name(key_shape, 'key'), key_shape, key)
                build_shape(location_name(value_shape, 'value'), value_shape, value)
              end
            end
          end
        end
      end

      def flat_map_entries(name, shape, values, key_shape, value_shape)
        values.each do |key, value|
          node(name, shape) do
            build_shape(location_name(key_shape, 'key'), key_shape, key)
            build_shape(location_name(value_shape, 'value'), value_shape, value)
          end
        end
      end

      def structure(name, shape, values)
        return node(name, shape) if values.empty?

        node(name, shape, structure_attrs(shape, values)) do
          shape.target.members.each do |member_name, member_shape|
            next if values[member_name].nil?
            next if xml_attribute?(member_shape)

            build_shape(location_name(member_shape, member_shape.location_name), member_shape, values[member_name])
          end
        end
      end

      def structure_attrs(shape, values)
        shape.target.members.each_with_object({}) do |(member_name, member_shape), attrs|
          if xml_attribute?(member_shape) && values.key?(member_name)
            attrs[location_name(member_shape, member_shape.location_name)] = values[member_name]
          end
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

      def union(name, shape, values) # rubocop:disable Metrics/AbcSize
        return node(name, shape) if values.empty?

        node(name, shape, structure_attrs(shape, values)) do
          if values.is_a?(Schema::Union)
            _name, member_shape = shape.target.member_by_type(values.class)
            build_shape(location_name(member_shape, member_shape.location_name), member_shape, values.value)
          else
            key, value = values.first
            if shape.target.member?(key)
              member_shape = shape.target.member(key)
              build_shape(location_name(member_shape, member_shape.location_name), member_shape, value)
            end
          end
        end
      end

      def location_name(shape, default = nil)
        shape.traits['smithy.api#xmlName'] || default
      end

      def flat?(shape)
        shape.traits.key?('smithy.api#xmlFlattened')
      end

      def xml_attribute?(shape)
        shape.traits.key?('smithy.api#xmlAttribute')
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
        attrs = shape_attrs(shape).merge(attrs)
        args << attrs
        @builder.node(name, *args, &)
      end

      def shape_attrs(shape)
        trait = 'smithy.api#xmlNamespace'
        xmlns = shape.traits[trait] || shape.target.traits[trait]
        return {} unless xmlns

        if (prefix = xmlns['prefix'])
          { "xmlns:#{prefix}" => xmlns['uri'] }
        else
          { 'xmlns' => xmlns['uri'] }
        end
      end
    end
  end
end
