# frozen_string_literal: true

module Smithy
  module Xml
    # XML-specific, lazily-built metadata derived from modeled shapes.
    # @api private
    module Extension
      class << self
        def structure_name(shape)
          shape.traits['smithy.api#xmlName'] || shape.target.traits['smithy.api#xmlName'] || shape.target.name
        end

        def member_name(shape, default = nil)
          shape.traits['smithy.api#xmlName'] || default
        end

        def members(shape)
          shape[:xml_members] ||= build_members(shape)
        end

        def member_index(shape)
          shape[:xml_member_index] ||= build_member_index(shape)
        end

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
            index[member_name(member, member.location_name)] = [name, member]
          end
          index.freeze
        end

        def build_namespace_attrs(shape)
          trait = 'smithy.api#xmlNamespace'
          xmlns = shape.traits[trait] || shape.target.traits[trait]
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
