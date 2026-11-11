# frozen_string_literal: true

require_relative 'encoder'

module Smithy
  module Cbor
    # @api private
    #
    # The CBOR view of a schema shape, prepared once and reused by the Builder and the Reader: encoded member keys,
    # wire name lookups, and which writer or reader each member needs. Like the Extension modules of smithy-json and
    # smithy-xml, it derives codec specific data from the schema, keeps it under codec-prefixed keys, and leaves the
    # schema itself as plain data about the shape. Like {Schema::Extension}, each result is
    # cached on the shape the first time it is asked for and never invalidated, so a schema must be completely built
    # before it is first used to build or parse a body. The caches belong to the shape and live as long as it does;
    # they hold nothing about the objects passed to the Builder.
    #
    # Entries are arrays, not objects, because the Builder and the Reader index them once per member:
    #
    # * build entry: [encoded member key, member target, kind, encoded one-entry-map header and key (unions only),
    #   duplicate bit]
    # * parse entry: [Ruby member name, member target, kind, duplicate bit, union member class, plain union member?]
    module Extension
      class << self
        # Ruby member name => build entry, for a structure or union.
        def build_plan(shape)
          shape[:cbor_build_plan] ||= resolve_build_plan(shape)
        end

        # [build plan, plain struct type] of a structure shape in one lookup, for the Builder's per-structure path.
        def structure_build_plan(shape)
          shape[:cbor_structure_build_plan] ||= [build_plan(shape), plain_struct_type(shape)].freeze
        end

        # [element target, kind] of a list or map shape, as the Builder writes it.
        def element_build_plan(shape)
          shape[:cbor_build_plan] ||= [(element = element_of(shape)), build_kind(element)].freeze
        end

        # The generated class of a structure shape if its #each_pair is Struct's own, so it cannot yield a member
        # twice; false otherwise. The Builder skips its duplicate member check for exactly that class.
        def plain_struct_type(shape)
          type = shape[:cbor_plain_type]
          type.nil? ? (shape[:cbor_plain_type] = resolve_plain_struct_type(shape)) : type
        end

        # Wire name => parse entry, for a structure or union.
        def parse_plan(shape)
          shape[:cbor_parse_plan] ||= resolve_parse_plan(shape)
        end

        # [element target, kind, sparse?] of a list or map shape, as the Reader reads it.
        def element_parse_plan(shape)
          shape[:cbor_parse_plan] ||= [
            (element = element_of(shape)), parse_kind(element), Schema::Extension.sparse?(shape)
          ].freeze
        end

        # How the Builder writes a value of the shape.
        def build_kind(target)
          target.is_a?(Schema::Shapes::BlobShape) ? :blob : parse_kind(target)
        end

        # How the Reader reads a value of the shape. Blobs are scalars.
        def parse_kind(target)
          case target
          when Schema::Shapes::ListShape then :list
          when Schema::Shapes::MapShape then :map
          when Schema::Shapes::StructureShape then :structure
          when Schema::Shapes::UnionShape then :union
          else :scalar
          end
        end

        private

        def element_of(shape)
          (shape.is_a?(Schema::Shapes::ListShape) ? shape.member : shape.value).target
        end

        def resolve_build_plan(shape)
          members = shape.members
          names = members.values.map(&:name)
          if (collision = names.detect { |name| names.count(name) > 1 })
            raise BuildError, "Members of #{shape.id} share the wire name #{collision}"
          end

          union = shape.is_a?(Schema::Shapes::UnionShape)
          members.each_with_index.to_h { |(name, member), index| [name, build_entry(member, index, union)] }.freeze
        end

        # The one-entry map header and key is only prepared for union members.
        def build_entry(member, index, union)
          key = Encoder.new.add(member.name).bytes.freeze
          union_key = Encoder.new.tap { |encoder| encoder.start_map(1) }.add(member.name).bytes.freeze if union
          target = member.target
          [key, target, build_kind(target), union_key, 1 << index].freeze
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
