# frozen_string_literal: true

module Smithy
  module Xml
    # Lookup helpers for XML SERDE using Smithy traits that affect XML
    # wire names and structure layout.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module resolves XML-specific SERDE behavior on demand
    # and stores resolved values in metadata:
    # - +shape[:xml_structure_name]+ caches the resolved XML element name for a
    #   structure or top-level structure member
    # - +shape[:xml_flattened]+ caches whether +@xmlFlattened+ is set on a
    #   wrapper member as a boolean
    # - +shape[:xml_frame_class]+ caches the XML parser frame class selected for
    #   a wrapper shape
    # - +member[:xml_name]+ caches the resolved XML wire name for a member
    # - +shape[:xml_members]+ partitions members into XML attributes vs elements
    # - +shape[:xml_member_index]+ caches the XML wire-name lookup index
    # - +shape[:xml_map_parts]+ caches resolved XML map key/value members and wire names
    # - +shape[:xml_namespace_attrs]+ caches resolved xmlns attributes
    # @api private
    module Extension
      class << self
        include Smithy::Schema::Shapes

        # Returns the XML element name, preferring the Smithy @xmlName trait.
        def structure_name(shape)
          shape[:xml_structure_name] ||=
            shape.traits['smithy.api#xmlName'] ||
            shape.target.traits['smithy.api#xmlName'] ||
            shape.target.name
        end

        # Returns whether the wrapper shape is marked with @xmlFlattened.
        def flattened(shape)
          boolean_trait?(shape, :xml_flattened, 'smithy.api#xmlFlattened')
        end

        # Returns whether the wrapper shape is marked with @xmlFlattened.
        def flattened?(shape)
          flattened(shape)
        end

        # Returns the cached parser frame class for a wrapper shape.
        def frame_class(shape)
          shape[:xml_frame_class] ||= begin
            klass = base_frame_class(shape.target)
            if klass == Parser::ListFrame && flattened?(shape)
              Parser::FlatListFrame
            elsif klass == Parser::MapFrame && flattened?(shape)
              Parser::MapEntryFrame
            else
              klass
            end
          end
        end

        # Returns the resolved XML wire name, preferring the Smithy @xmlName
        # trait and caching the result as +member[:xml_name]+.
        def wire_name(member)
          member[:xml_name] ||= member.traits['smithy.api#xmlName'] || member.name
        end

        # Partitioned XML members for the builder => { attributes:, elements: }.
        #
        # Each entry is:
        # - [ruby_member_name, resolved_xml_name, member_shape]
        def members(shape)
          shape[:xml_members] ||= build_members(shape)
        end

        # XML members that serialize as attributes.
        def attribute_members(shape)
          members(shape)[:attributes]
        end

        # XML members that serialize as child elements.
        def element_members(shape)
          members(shape)[:elements]
        end

        # Resolved XML wire name => [ruby_member_name, member_shape]
        def member_index(shape)
          shape[:xml_member_index] ||= build_member_index(shape)
        end

        # Resolved XML map parts as:
        # - [key_name, key_member, value_name, value_member]
        def map_parts(shape)
          shape[:xml_map_parts] ||= build_map_parts(shape)
        end

        # XML namespace attributes derived from the Smithy @xmlNamespace trait.
        def namespace_attrs(shape)
          shape[:xml_namespace_attrs] ||= build_namespace_attrs(shape)
        end

        private

        def build_members(shape)
          attributes = []
          elements = []

          shape.members.each do |name, member|
            xml_name = wire_name(member)
            entry = [name, xml_name, member].freeze
            if xml_attribute?(member)
              attributes << entry
            else
              elements << entry
            end
          end

          {
            attributes: attributes.freeze,
            elements: elements.freeze
          }.freeze
        end

        def build_member_index(shape)
          index = {}
          shape.members.each do |name, member|
            next unless member.name

            index[wire_name(member)] = [name, member].freeze
          end
          index.freeze
        end

        def build_map_parts(shape)
          key_member = shape.target.key
          value_member = shape.target.value
          [
            wire_name(key_member),
            key_member,
            wire_name(value_member),
            value_member
          ].freeze
        end

        def build_namespace_attrs(shape)
          xmlns = shape.traits['smithy.api#xmlNamespace'] || shape.target.traits['smithy.api#xmlNamespace']
          return {}.freeze unless xmlns

          attrs =
            if (prefix = xmlns['prefix'])
              { "xmlns:#{prefix}" => xmlns['uri'] }
            else
              { 'xmlns' => xmlns['uri'] }
            end
          attrs.freeze
        end

        def xml_attribute?(shape)
          shape.traits.key?('smithy.api#xmlAttribute')
        end

        def boolean_trait?(trait_owner, metadata_key, trait_name)
          value = trait_owner[metadata_key]
          return value unless value.nil?

          trait_owner[metadata_key] = trait_owner.traits.key?(trait_name)
        end

        def base_frame_class(target) # rubocop:disable Metrics/CyclomaticComplexity
          case target
          when BigDecimalShape then Parser::BigDecimalFrame
          when BlobShape then Parser::BlobFrame
          when BooleanShape then Parser::BooleanFrame
          when EnumShape, StringShape then Parser::StringFrame
          when FloatShape then Parser::FloatFrame
          when IntegerShape, IntEnumShape then Parser::IntegerFrame
          when ListShape then Parser::ListFrame
          when MapShape then Parser::MapFrame
          when StructureShape, UnionShape then Parser::StructureFrame
          when TimestampShape then Parser::TimestampFrame
          end
        end
      end
    end
  end
end
