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
        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        target ||= []
        @builder = DocBuilder.new(target: target, indent: @indent, pad: @pad)
        structure(location_name(ref, ref.member_name), ref, data)
        target.join
      end

      private

      def structure(name, ref, values)
        # if values.empty?
        #   node(name, ref)
        # else
          node(name, ref, structure_attrs(ref, values)) do
            ref.shape.members.each do |member_name, member_ref|
              next if values[member_name].nil?
              next if xml_attribute?(member_ref)
              member(location_name(member_ref, member_ref.member_name), member_ref, values[member_name])
            end
          end
        # end
      end

      def structure_attrs(ref, values)
        ref.shape.members.inject({}) do |attrs, (member_name, member_ref)|
          if xml_attribute?(member_ref) && values.key?(member_name)
            attrs[location_name(member_ref, member_ref.member_name)] = values[member_name]
          end
          attrs
        end
      end

      def list(name, ref, values)
        member_ref = ref.shape.member
        if ref.traits.key?('smithy.api#xmlFlattened')
          values.each do |value|
            member(name, member_ref, value)
          end
        else
          node(name, ref) do
            values.each do |value|
              member(location_name(member_ref, 'member'), ref.shape.member, value)
            end
          end
        end
      end

      def map(name, ref, hash)
        key_ref = ref.shape.key
        value_ref = ref.shape.value
        if ref.traits.key?('smithy.api#xmlFlattened')
          hash.each do |key, value|
            node(name, ref) do
              member(location_name(key_ref, 'key'), key_ref, key)
              member(location_name(value_ref, 'value'), value_ref, value)
            end
          end
        else
          node(name, ref) do
            hash.each do |key, value|
              # Pass in a new ShapeRef to create an entry node
              node('entry', ShapeRef.new) do
                member(location_name(key_ref, 'key'), key_ref, key)
                member(location_name(value_ref, 'value'), value_ref, value)
              end
            end
          end
        end
      end

      def member(name, ref, value)
        case ref.shape
        when BlobShape then node(name, ref, blob(value))
        when ListShape then list(name, ref, value)
        when MapShape then map(name, ref, value)
        when StructureShape then structure(name, ref, value)
        when TimestampShape then node(name, ref, timestamp(ref, value))
        else node(name, ref, value.to_s)
        end
      end

      def blob(value)
        Base64.strict_encode64(value.respond_to?(:read) ? value.read : value)
      end

      def timestamp(ref, value)
        case ref['timestampFormat'] || ref.shape['timestampFormat']
        when 'unixTimestamp' then value.to_i
        when 'rfc822' then value.utc.httpdate
        else
          # xml defaults to iso8601
          value.utc.iso8601
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
      def node(name, ref, *args, &)
        attrs = args.last.is_a?(Hash) ? args.pop : {}
        attrs = shape_attrs(ref).merge(attrs)
        args << attrs
        @builder.node(name, *args, &)
      end

      def shape_attrs(ref)
        return {} unless (xmlns = ref.traits['smithy.api#xmlNamespace'])

        if (prefix = xmlns['prefix'])
          { "xmlns:#{prefix}" => xmlns['uri'] }
        else
          { 'xmlns' => xmlns['uri'] }
        end
      end

      def xml_attribute?(ref)
        ref.traits.key?('smithy.api#xmlAttribute')
      end

      def location_name(ref, default = nil)
        ref.traits['smithy.api#xmlName'] || default
      end
    end
  end
end
