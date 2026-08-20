# frozen_string_literal: true

module Smithy
  module Xml
    # Lookup helpers for XML serde using the Smithy @xmlName, @xmlAttribute,
    # and @xmlNamespace traits.
    # @api private
    module Extension
      class << self
        # Returns the XML element name, preferring the Smithy @xmlName trait.
        def structure_name(shape)
          shape.traits[:xml_name] || shape.target.traits[:xml_name] || shape.target.name
        end

        # Returns the XML member name, preferring the Smithy @xmlName trait.
        def member_name(shape, default = nil)
          shape.traits[:xml_name] || default
        end

        # Partitioned XML members for the builder => { attributes:, elements: }.
        def members(shape)
          shape[:xml_members] ||= build_members(shape)
        end

        # Smithy @xmlName or modeled member name => [ruby_member_name, member_shape]
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
            index[member_name(member, member.model_name)] = [name, member]
          end
          index.freeze
        end

        def build_namespace_attrs(shape)
          xmlns = shape.traits[:xml_namespace] || shape.target.traits[:xml_namespace]
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
          shape.traits.key?(:xml_attribute)
        end
      end
    end
  end
end
