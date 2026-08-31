# frozen_string_literal: true

module Smithy
  module Xml
    # Lookup helpers for XML serde using Smithy traits that affect XML
    # wire names and structure layout.
    #
    # Raw Smithy trait data remains on +shape.traits+ and +member.traits+ with
    # string keys. This module resolves XML-specific serde behavior on demand
    # and stores resolved values in metadata:
    # - +shape[:xml_structure_name]+ caches the resolved XML element name for a
    #   structure or top-level structure member
    # - +shape[:xml_flattened]+ caches whether +@xmlFlattened+ is set on a
    #   wrapper member as +:set+ or +:unset+
    # - +shape[:xml_frame_class]+ caches the XML parser frame class selected for
    #   a wrapper shape
    # - +member[:xml_name]+ caches the resolved XML wire name for a member
    # - +shape[:xml_members]+ partitions members into XML attributes vs elements
    # - +shape[:xml_member_index]+ caches the XML wire-name lookup index
    # - +shape[:xml_namespace_attrs]+ caches resolved xmlns attributes
    # @api private
    module Extension
      class << self
        # Returns the XML element name, preferring the Smithy @xmlName trait.
        def structure_name(shape)
          shape[:xml_structure_name] ||=
            shape.traits['smithy.api#xmlName'] ||
            shape.target.traits['smithy.api#xmlName'] ||
            shape.target.name
        end

        # Returns the cached xmlFlattened state for a wrapper shape as
        # +:set+ or +:unset+.
        def flattened(shape)
          shape[:xml_flattened] ||= shape.traits.key?('smithy.api#xmlFlattened') ? :set : :unset
        end

        # Returns true when the wrapper shape is marked with @xmlFlattened.
        def flattened?(shape)
          flattened(shape) == :set
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

        # Resolved XML wire name => [ruby_member_name, member_shape]
        def member_index(shape)
          shape[:xml_member_index] ||= build_member_index(shape)
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
