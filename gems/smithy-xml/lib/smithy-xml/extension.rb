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
    # - +member[:xml_name]+ caches the resolved XML wire name for a member
    # - +shape[:xml_members]+ partitions members into XML attributes vs elements
    # - +shape[:xml_member_index]+ caches the XML wire-name lookup index
    # - +shape[:xml_namespace_attrs]+ caches resolved xmlns attributes
    # @api private
    module Extension
      extend Smithy::Schema::ExtensionHelpers

      class << self
        # Returns the XML element name, preferring the Smithy @xmlName trait.
        def structure_name(shape)
          shape[:xml_structure_name] ||=
            shape.traits['smithy.api#xmlName'] ||
            shape.target.traits['smithy.api#xmlName'] ||
            shape.target.name
        end

        # Returns the resolved XML wire name, preferring the Smithy @xmlName
        # trait and caching the result as +member[:xml_name]+.
        def wire_name(member)
          member[:xml_name] ||= member.traits['smithy.api#xmlName'] || member.name
        end

        # Partitioned XML members for the builder => { attributes:, elements: }.
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
            entry = [name, member].freeze
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
      end
    end
  end
end
