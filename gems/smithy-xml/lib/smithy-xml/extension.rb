# frozen_string_literal: true

module Smithy
  module Xml
    # XML-specific lookup helpers and cached serde metadata.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This extension caches XML-specific values under
    # +object[KEY]+; generic target metadata remains owned by
    # +Schema::Extension+.
    # @api private
    module Extension
      KEY = :xml

      class << self
        # Returns cached XML metadata for a shape or member.
        #
        # Example:
        #   Extension.fetch(member)
        #   # => { xml_wire_name: 'Item', ... }
        def fetch(shape)
          shape[KEY] || build_and_cache(shape)
        end

        # Returns the XML wrapper or structure name.
        #
        # Example:
        #   Extension.structure_name(shape)
        #   # => 'Result'
        def structure_name(shape)
          (shape[KEY] || build_and_cache(shape))[:xml_structure_name]
        end

        # Preserves the existing true-or-nil return contract.
        #
        # Example:
        #   Extension.flattened?(member)
        #   # => true
        def flattened?(shape)
          shape.traits.key?('smithy.api#xmlFlattened') || nil
        end

        # Returns the parser frame class for the shape.
        #
        # Example:
        #   Extension.frame_class(shape)
        #   # => Parser::ListFrame
        def frame_class(shape)
          (shape[KEY] || build_and_cache(shape))[:xml_frame_class]
        end

        # Returns the resolved XML member name.
        #
        # Example:
        #   Extension.wire_name(member)
        #   # => 'Item'
        def wire_name(member)
          (member[KEY] || build_and_cache(member))[:xml_wire_name]
        end

        # Returns XML members partitioned into attributes and elements.
        #
        # Example:
        #   Extension.members(shape)
        #   # => { attributes: [...], elements: [...] }
        def members(shape)
          (shape[KEY] || build_and_cache(shape))[:xml_members]
        end

        def attribute_members(shape)
          members(shape)[:attributes]
        end

        def element_members(shape)
          members(shape)[:elements]
        end

        def member_index(shape)
          (shape[KEY] || build_and_cache(shape))[:xml_member_index]
        end

        def namespace_attrs(shape)
          (shape[KEY] || build_and_cache(shape))[:xml_namespace_attrs]
        end

        def map_parts(shape)
          (shape[KEY] || build_and_cache(shape))[:xml_map_parts]
        end

        def timestamp_format(shape)
          Schema::Extension.timestamp_format(shape)
        end

        def sparse?(shape)
          Schema::Extension.sparse?(shape)
        end

        private

        def build_and_cache(shape)
          Schema::Extension.fetch(shape)
          shape[KEY] =
            if shape.is_a?(Schema::Shapes::MemberShape)
              build_member_metadata(shape)
            else
              build_shape_metadata(shape)
            end
        end

        def build_shape_metadata(shape) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          target = shape.target
          metadata = {
            xml_structure_name: shape.traits['smithy.api#xmlName'] || target.name,
            xml_namespace_attrs: build_namespace_attrs(shape, target),
            xml_frame_class: frame_class_for(target, flattened?(shape))
          }
          if target.is_a?(Schema::Shapes::StructureShape) || target.is_a?(Schema::Shapes::UnionShape)
            members = { attributes: [], elements: [] }
            index = {}
            Schema::Extension.each_member(shape) do |ruby_name, member|
              member_metadata = fetch(member)
              xml_name = member_metadata[:xml_wire_name]
              entry = [ruby_name, xml_name, member].freeze
              index[xml_name] = [ruby_name, member].freeze
              members[member_metadata[:xml_attribute] ? :attributes : :elements] << entry
            end
            metadata[:xml_members] = {
              attributes: members[:attributes].freeze,
              elements: members[:elements].freeze
            }.freeze
            metadata[:xml_member_index] = index.freeze
          else
            add_map_parts(metadata, target)
          end
          metadata.freeze
        end

        def build_member_metadata(member) # rubocop:disable Metrics/AbcSize
          target = member.target
          xml_name = member.traits['smithy.api#xmlName']
          structure_name = xml_name || target.traits['smithy.api#xmlName']
          if structure_name.nil? &&
             (target.is_a?(Schema::Shapes::StructureShape) || target.is_a?(Schema::Shapes::UnionShape))
            structure_name = target.name
          end
          metadata = {
            xml_structure_name: structure_name || member.name,
            xml_wire_name: xml_name || member.name,
            xml_namespace_attrs: build_namespace_attrs(member, target),
            xml_attribute: member.traits.key?('smithy.api#xmlAttribute'),
            xml_frame_class: frame_class_for(target, flattened?(member))
          }
          add_map_parts(metadata, target)
          metadata.freeze
        end

        def add_map_parts(metadata, target)
          return unless target.is_a?(Schema::Shapes::MapShape)

          key_member = target.key
          value_member = target.value
          return unless key_member && value_member

          metadata[:xml_map_parts] = [
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
