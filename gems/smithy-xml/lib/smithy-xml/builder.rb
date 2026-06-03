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

      def build(shape, data, target = nil)
        ref = shape.is_a?(MemberShape) ? shape : MemberShape.new(target: shape)
        target ||= []
        @builder = DocBuilder.new(target: target, indent: @indent, pad: @pad)
        structure(ref.location_name || ref.target.traits['smithy.api#xmlName'] || ref.target.name, ref, data)
        target.join
      end

      private

      def shape(name, ref, value)
        case ref.target
        when BlobShape then node(name, ref, blob(value))
        when ListShape then list(name, ref, value)
        when MapShape then map(name, ref, value)
        when StructureShape then structure(name, ref, value)
        when TimestampShape then node(name, ref, timestamp(ref, value))
        when UnionShape then union(name, ref, value)
        else node(name, ref, value.to_s)
        end
      end

      def blob(value)
        Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
      end

      def list(name, ref, values)
        member_ref = ref.target.member
        if flat?(ref)
          values.each do |value|
            shape(name, member_ref, value)
          end
        else
          node(name, ref) do
            values.each do |value|
              shape(location_name(member_ref, 'member'), ref.target.member, value)
            end
          end
        end
      end

      def map(name, ref, values) # rubocop:disable Metrics/AbcSize
        key_ref = ref.target.key
        value_ref = ref.target.value
        if flat?(ref)
          values.each do |key, value|
            node(name, ref) do
              shape(location_name(key_ref, 'key'), key_ref, key)
              shape(location_name(value_ref, 'value'), value_ref, value)
            end
          end
        else
          node(name, ref) do
            values.each do |key, value|
              node('entry', MemberShape.new(target: MapShape.new)) do
                shape(location_name(key_ref, 'key'), key_ref, key)
                shape(location_name(value_ref, 'value'), value_ref, value)
              end
            end
          end
        end
      end

      def structure(name, ref, values)
        return node(name, ref) if values.empty?

        node(name, ref, structure_attrs(ref, values)) do
          ref.target.members.each do |member_name, member_ref|
            next if values[member_name].nil?
            next if xml_attribute?(member_ref)

            shape(location_name(member_ref, member_ref.location_name), member_ref, values[member_name])
          end
        end
      end

      def structure_attrs(ref, values)
        ref.target.members.each_with_object({}) do |(member_name, member_ref), attrs|
          if xml_attribute?(member_ref) && values.key?(member_name)
            attrs[location_name(member_ref, member_ref.location_name)] = values[member_name]
          end
        end
      end

      def timestamp(ref, value)
        trait = 'smithy.api#timestampFormat'
        case ref.traits[trait] || ref.target.traits[trait]
        when 'epoch-seconds' then value.to_i.to_s
        when 'http-date' then value.utc.httpdate
        else
          # default to date-time
          value.utc.iso8601
        end
      end

      def union(name, ref, values) # rubocop:disable Metrics/AbcSize
        return node(name, ref) if values.empty?

        node(name, ref, structure_attrs(ref, values)) do
          if values.is_a?(Schema::Union)
            _name, member_ref = ref.target.member_by_type(values.class)
            shape(location_name(member_ref, member_ref.location_name), member_ref, values.value)
          else
            key, value = values.first
            if ref.target.member?(key)
              member_ref = ref.target.member(key)
              shape(location_name(member_ref, member_ref.location_name), member_ref, value)
            end
          end
        end
      end

      def location_name(ref, default = nil)
        ref.traits['smithy.api#xmlName'] || default
      end

      def flat?(ref)
        ref.traits.key?('smithy.api#xmlFlattened')
      end

      def xml_attribute?(ref)
        ref.traits.key?('smithy.api#xmlAttribute')
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
      def node(name, ref, *args, &)
        attrs = args.last.is_a?(Hash) ? args.pop : {}
        attrs = shape_attrs(ref).merge(attrs)
        args << attrs
        @builder.node(name, *args, &)
      end

      def shape_attrs(ref)
        trait = 'smithy.api#xmlNamespace'
        xmlns = ref.traits[trait] || ref.target.traits[trait]
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
