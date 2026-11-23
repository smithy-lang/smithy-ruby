# frozen_string_literal: true

require_relative 'encoder'

module Smithy
  module Cbor
    # @api private
    #
    # The CBOR view of a schema shape, prepared once and reused by the Builder and the Reader: encoded member keys,
    # wire name lookups, and which writer or reader each member needs. Each result is cached on the shape under a
    # cbor_ key the first time it is asked for and never invalidated, so a schema must be completely built before it
    # is first used to build or parse a body. The caches hold nothing about the objects passed to the Builder.
    #
    # The plans also record how generated types are built and iterated (see {.plain_struct_type} and the union
    # member classes of {.parse_plan}), so a generated type must not be reopened to change #each_pair,
    # #initialize, #[]=, .new or .allocate after its shape is first used.
    #
    # Entries are frozen arrays, read once per member; {BuildEntry} and {ParseEntry} name their fields.
    module Extension
      # Fields of a build entry.
      module BuildEntry
        KEY = 0 # encoded member key
        TARGET = 1 # member target shape
        KIND = 2 # how the Builder writes the value
        UNION_KEY = 3 # encoded one-entry map header and member key; union members only
        BIT = 4 # duplicate member bit
      end

      # Fields of a parse entry.
      module ParseEntry
        NAME = 0 # Ruby member name
        TARGET = 1 # member target shape
        KIND = 2 # how the Reader reads the value
        BIT = 3 # duplicate member bit
        MEMBER_CLASS = 4 # union member class; union members only
        PLAIN_MEMBER = 5 # whether that class is built like Struct's own; union members only
      end

      class << self
        # Ruby member name => build entry, for a structure or union.
        def build_plan(shape)
          shape[:cbor_build_plan] ||= resolve_build_plan(shape)
        end

        # [build plan, plain struct type] of a structure shape in one lookup, for the Builder's per-structure path.
        def structure_build_plan(shape)
          shape[:cbor_structure_build_plan] ||= [build_plan(shape), plain_struct_type(shape)].freeze
        end

        # [value target, kind] of a list or map shape, as the Builder writes it. The value is the list member
        # (member.target) or the map value (value.target); map keys are always text and have no plan.
        def collection_value_build_plan(shape)
          shape[:cbor_build_plan] ||= [(value = collection_value_of(shape)), build_kind(value)].freeze
        end

        # The generated class of a structure shape if its #each_pair is Struct's own, so it cannot yield a member
        # twice; false otherwise. The Builder skips its duplicate member check for exactly that class.
        def plain_struct_type(shape)
          shape.fetch_metadata(:cbor_plain_type) { resolve_plain_struct_type(shape) }
        end

        # Wire name => parse entry, for a structure or union.
        def parse_plan(shape)
          shape[:cbor_parse_plan] ||= resolve_parse_plan(shape)
        end

        # [value target, kind] of a list or map shape, as the Reader reads it. The value is the list member
        # (member.target) or the map value (value.target); map keys are always text and have no plan.
        def collection_value_parse_plan(shape)
          shape[:cbor_parse_plan] ||= [(value = collection_value_of(shape)), parse_kind(value)].freeze
        end

        # How the Builder writes a value of the shape, cached on the shape.
        def build_kind(shape)
          shape[:cbor_build_kind] ||= shape.is_a?(Schema::Shapes::BlobShape) ? :blob : parse_kind(shape)
        end

        # How the Reader reads a value of the shape, cached on the shape. Blobs are scalars.
        def parse_kind(shape)
          shape[:cbor_parse_kind] ||=
            case shape
            when Schema::Shapes::ListShape then :list
            when Schema::Shapes::MapShape then :map
            when Schema::Shapes::StructureShape then :structure
            when Schema::Shapes::UnionShape then :union
            else :scalar
            end
        end

        private

        def collection_value_of(shape)
          (shape.is_a?(Schema::Shapes::ListShape) ? shape.member : shape.value).target
        end

        def resolve_build_plan(shape)
          members = shape.members
          wire_names = {}
          members.each_value do |member|
            if wire_names.key?(member.name)
              raise BuildError, "Members of #{shape.id} share the wire name #{member.name}"
            end

            wire_names[member.name] = true
          end

          union = shape.is_a?(Schema::Shapes::UnionShape)
          members.each_with_index.to_h { |(name, member), index| [name, build_entry(member, index, union)] }.freeze
        end

        # The one-entry map header and key is only prepared for union members.
        def build_entry(member, index, union)
          key = Encoder.new.add(member.name).bytes.freeze
          union_key = one_entry_map_key(key) if union
          target = member.target
          [key, target, build_kind(target), union_key, 1 << index].freeze
        end

        def one_entry_map_key(key)
          encoder = Encoder.new
          encoder.start_map(1)
          encoder.add_encoded(key)
          encoder.bytes.freeze
        end

        def resolve_plain_struct_type(shape)
          type = shape.type
          type.is_a?(Class) && type <= Struct && type.instance_method(:each_pair).owner == Struct ? type : false
        end

        def resolve_parse_plan(shape)
          union = shape.is_a?(Schema::Shapes::UnionShape)
          Schema::Extension.wire_index(shape).each_with_index.to_h do |(wire_name, (name, member)), index|
            klass = shape.member_type(name) if union
            target = member.target
            entry = [name, target, parse_kind(target), 1 << index, klass, union && plain_struct_class?(klass)]
            [wire_name, entry.freeze]
          end.freeze
        end

        # Whether a union member class is built exactly like Struct's own: the Reader then allocates it and sets the
        # one member directly, instead of calling .new with a keyword hash. Anything customized on the way, including
        # #[]=, keeps the normal constructor.
        def plain_struct_class?(klass)
          base = klass.ancestors.find { |ancestor| ancestor.is_a?(Class) && ancestor.superclass == Struct }
          base && struct_construction?(klass, base)
        end

        def struct_construction?(klass, base)
          %i[initialize []=].all? { |name| klass.instance_method(name).owner == Struct } &&
            klass.method(:new).owner == base.singleton_class &&
            klass.method(:allocate).owner == Class
        end
      end
    end
  end
end
