# frozen_string_literal: true

module Smithy
  module Xml
    # XML-specific lookup helpers and cached serde metadata.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. Resolved XML values are cached as flat, XML-prefixed keys
    # on their owning shape or member.
    # @api private
    module Extension
      class << self
        # Returns the XML wrapper or structure name.
        def structure_name(shape)
          shape.fetch_metadata(:xml_structure_name) do
            resolve_structure_name(shape)
          end
        end

        # Returns whether the XML value is flattened.
        def flattened?(shape)
          shape.fetch_metadata(:xml_flattened) do
            shape.traits.key?('smithy.api#xmlFlattened')
          end
        end

        # Returns the parser frame class for the shape.
        def frame_class(shape)
          shape.fetch_metadata(:xml_frame_class) do
            frame_class_for(shape.target, flattened?(shape))
          end
        end

        # Returns the resolved XML member name.
        def wire_name(member)
          member[:xml_wire_name] ||= member.traits['smithy.api#xmlName'] || member.name
        end

        # Returns XML members partitioned into attributes and elements.
        def members(shape)
          resolve_members(shape)
          shape[:xml_members]
        end

        def attribute_members(shape)
          resolve_members(shape)
          shape[:xml_attribute_members]
        end

        def element_members(shape)
          resolve_members(shape)
          shape[:xml_element_members]
        end

        def member_index(shape)
          resolve_members(shape)
          shape[:xml_member_index]
        end

        def namespace_attrs(shape)
          shape[:xml_namespace_attrs] ||= build_namespace_attrs(shape, shape.target)
        end

        def map_parts(shape)
          shape.fetch_metadata(:xml_map_parts) do
            build_map_parts(shape.target)
          end
        end

        def timestamp_format(shape)
          Schema::Extension.timestamp_format(shape)
        end

        def sparse?(shape)
          Schema::Extension.sparse?(shape)
        end

        private

        def resolve_structure_name(shape) # rubocop:disable Metrics/CyclomaticComplexity
          target = shape.target
          return shape.traits['smithy.api#xmlName'] || target.name unless shape.is_a?(Schema::Shapes::MemberShape)

          xml_name = shape.traits['smithy.api#xmlName']
          structure_name = xml_name || target.traits['smithy.api#xmlName']
          if structure_name.nil? &&
             (target.is_a?(Schema::Shapes::StructureShape) || target.is_a?(Schema::Shapes::UnionShape))
            structure_name = target.name
          end
          structure_name || shape.name
        end

        def resolve_members(shape) # rubocop:disable Metrics/AbcSize
          shape.fetch_metadata(:xml_members_resolved) do
            attributes = []
            elements = []
            index = {}
            Schema::Extension.each_member(shape) do |ruby_name, member|
              xml_name = wire_name(member)
              entry = [ruby_name, xml_name, member].freeze
              index[xml_name] = [ruby_name, member].freeze
              (attribute?(member) ? attributes : elements) << entry
            end

            attributes.freeze
            elements.freeze
            shape[:xml_attribute_members] = attributes
            shape[:xml_element_members] = elements
            shape[:xml_members] = { attributes: attributes, elements: elements }.freeze
            shape[:xml_member_index] = index.freeze
            true
          end
        end

        def attribute?(member)
          member.fetch_metadata(:xml_attribute) do
            member.traits.key?('smithy.api#xmlAttribute')
          end
        end

        def build_map_parts(target)
          return unless target.is_a?(Schema::Shapes::MapShape)

          key_member = target.key
          value_member = target.value
          return unless key_member && value_member

          [
            wire_name(key_member), key_member, wire_name(value_member), value_member
          ].freeze
        end

        def build_namespace_attrs(shape, target)
          xmlns = shape.traits['smithy.api#xmlNamespace']
          xmlns ||= target.traits['smithy.api#xmlNamespace'] if shape.is_a?(Schema::Shapes::MemberShape)
          return {}.freeze unless xmlns

          if (prefix = xmlns['prefix'])
            { "xmlns:#{prefix}" => xmlns['uri'] }.freeze
          else
            { 'xmlns' => xmlns['uri'] }.freeze
          end
        end

        def frame_class_for(target, flattened)
          klass = base_frame_class(target)
          return Parser::FlatListFrame if klass == Parser::ListFrame && flattened
          return Parser::MapEntryFrame if klass == Parser::MapFrame && flattened

          klass
        end

        def base_frame_class(target) # rubocop:disable Metrics/CyclomaticComplexity
          case target
          when Schema::Shapes::BigDecimalShape then Parser::BigDecimalFrame
          when Schema::Shapes::BlobShape then Parser::BlobFrame
          when Schema::Shapes::BooleanShape then Parser::BooleanFrame
          when Schema::Shapes::EnumShape, Schema::Shapes::StringShape then Parser::StringFrame
          when Schema::Shapes::FloatShape then Parser::FloatFrame
          when Schema::Shapes::IntegerShape, Schema::Shapes::IntEnumShape then Parser::IntegerFrame
          when Schema::Shapes::ListShape then Parser::ListFrame
          when Schema::Shapes::MapShape then Parser::MapFrame
          when Schema::Shapes::StructureShape, Schema::Shapes::UnionShape then Parser::StructureFrame
          when Schema::Shapes::TimestampShape then Parser::TimestampFrame
          end
        end
      end
    end
  end
end
