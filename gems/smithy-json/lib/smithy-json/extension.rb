# frozen_string_literal: true

module Smithy
  module Json
    # JSON-specific lookup helpers and cached serde metadata.
    #
    # Raw Smithy trait data remains on +member.traits+ with string keys. This
    # extension resolves JSON wire names and member indexes on demand, then
    # caches them under +object[KEY]+. Generic shape and trait metadata remains
    # owned by Schema::Extension.
    # @api private
    module Extension
      KEY = :json

      class << self
        # Resolves and returns JSON metadata for a structure, union, or member.
        #
        # Example:
        #   Extension.fetch(member)
        #   # => { json_name: 'wireName' }
        def fetch(shape)
          return shape[KEY] if shape.key?(KEY)

          shape[KEY] =
            case shape
            when Schema::Shapes::StructureShape, Schema::Shapes::UnionShape
              build_structure_metadata(shape)
            when Schema::Shapes::MemberShape
              build_member_metadata(shape)
            end
        end

        # Returns the JSON parse lookup index cached in structure or union
        # metadata.
        #
        # The index maps:
        # - resolved JSON wire name
        # - to [ruby_member_name, member_shape, target_shape_ref]
        #
        # Example:
        #   Extension.wire_index(shape)
        #   # => { 'wireName' => [:ruby_name, member, Schema::Extension::SHAPE_STRING] }
        def wire_index(shape)
          fetch(shape)[:json_wire_index]
        end

        # Returns the JSON build lookup index cached in structure or union
        # metadata.
        #
        # The index maps:
        # - Ruby member name
        # - to [resolved JSON wire name, member_shape, target_shape_ref]
        #
        # Example:
        #   Extension.member_index(shape)
        #   # => { ruby_name: ['wireName', member, Schema::Extension::SHAPE_STRING] }
        def member_index(shape)
          fetch(shape)[:json_member_index]
        end

        # Returns the effective JSON member name: +smithy.api#jsonName+ when
        # present, otherwise the modeled member name.
        #
        # Example:
        #   Extension.wire_name(member)
        #   # => 'wireName'
        def wire_name(member)
          fetch(member)[:json_name]
        end

        # Returns the resolved timestamp format for JSON serialization.
        #
        # Example:
        #   Extension.timestamp_format(member)
        #   # => 'date-time'
        def timestamp_format(shape)
          Schema::Extension.timestamp_format(shape)
        end

        private

        def build_structure_metadata(shape)
          json_wire_index = {}
          json_member_index = {}

          Schema::Extension.each_member(shape) do |member_name, member_shape|
            json_name = wire_name(member_shape)
            target_shape = Schema::Extension.target_shape(member_shape)
            json_wire_index[json_name] = [member_name, member_shape, target_shape].freeze
            json_member_index[member_name] = [json_name, member_shape, target_shape].freeze
          end

          {
            json_wire_index: json_wire_index.freeze,
            json_member_index: json_member_index.freeze
          }.freeze
        end

        def build_member_metadata(member)
          { json_name: member.traits['smithy.api#jsonName'] || member.name }.freeze
        end
      end
    end
  end
end
