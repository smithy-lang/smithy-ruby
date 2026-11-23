# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../support/cbor_spec_helper'

module Smithy
  module Cbor
    describe Extension do
      let(:shapes) { CborSpecHelper.schema_shapes }
      let(:shape) { SchemaHelper.sample_schema(shapes: shapes).const_get(:Structure) }

      describe '.build_plan' do
        it 'maps Ruby member names to encoded keys, targets, kinds and duplicate bits' do
          entry = described_class.build_plan(shape)[:string]
          fields = Extension::BuildEntry
          expect(entry[fields::KEY]).to eq(Encoder.new.add('string').bytes)
          expect(entry[fields::TARGET]).to eq(shape.member(:string).target)
          expect(entry[fields::KIND]).to eq(:scalar)
          expect(entry[fields::UNION_KEY]).to be_nil
          expect(entry[fields::BIT]).to eq(1 << shape.members.keys.index(:string))
        end

        it 'prepares the one-entry map header and key for union members' do
          entry = described_class.build_plan(shape.member(:union).target)[:string]
          expect(entry[Extension::BuildEntry::UNION_KEY]).to eq("\xa1".b + entry[Extension::BuildEntry::KEY])
          expect(entry[Extension::BuildEntry::KEY]).to eq("\x66string".b)
        end

        it 'is cached on the shape and frozen' do
          plan = described_class.build_plan(shape)
          expect(described_class.build_plan(shape)).to equal(plan)
          expect(shape[:cbor_build_plan]).to equal(plan)
          expect(plan).to be_frozen
        end

        it 'does not see members added after first use' do
          described_class.build_plan(shape)
          shape.add_member(:late, Schema::Shapes::MemberShape.new(name: 'late', target: Schema::Shapes::Prelude::String))
          expect(described_class.build_plan(shape)).not_to have_key(:late)
        end

        it 'raises when two members share a wire name' do
          shape.add_member(:other, Schema::Shapes::MemberShape.new(name: 'string', target: Schema::Shapes::Prelude::String))
          expect { described_class.build_plan(shape) }
            .to raise_error(BuildError, "Members of #{shape.id} share the wire name string")
        end

        it 'marks blob members as blobs for the builder and scalars for the reader' do
          expect(described_class.build_plan(shape)[:blob][Extension::BuildEntry::KIND]).to eq(:blob)
          expect(described_class.parse_plan(shape)['blob'][Extension::ParseEntry::KIND]).to eq(:scalar)
        end
      end

      describe '.structure_build_plan' do
        it 'returns the build plan and plain struct type, cached on the shape' do
          plan = described_class.structure_build_plan(shape)
          expect(plan).to eq([described_class.build_plan(shape), shape.type])
          expect(described_class.structure_build_plan(shape)).to equal(plan)
        end
      end

      describe '.plain_struct_type' do
        it 'is the generated class when #each_pair is Struct\'s own' do
          expect(described_class.plain_struct_type(shape)).to equal(shape.type)
        end

        it 'is false when the generated class replaces #each_pair' do
          shape.type.class_eval { def each_pair = nil }
          expect(described_class.plain_struct_type(shape)).to be(false)
        end

        it 'is false for a type that is not a Struct' do
          shape.type = Class.new
          expect(described_class.plain_struct_type(shape)).to be(false)
        end
      end

      describe '.parse_plan' do
        it 'maps wire names to Ruby names, targets, kinds and duplicate bits' do
          entry = described_class.parse_plan(shape)['intEnum']
          fields = Extension::ParseEntry
          expect(entry.values_at(fields::NAME, fields::TARGET, fields::KIND))
            .to eq([:int_enum, shape.member(:int_enum).target, :scalar])
          expect(entry[fields::BIT]).to eq(1 << shape.members.keys.index(:int_enum))
          expect(entry.values_at(fields::MEMBER_CLASS, fields::PLAIN_MEMBER)).to eq([nil, false])
        end

        it 'records union member classes that are built like Struct\'s own' do
          union = shape.member(:union).target
          entry = described_class.parse_plan(union)['string']
          expect(entry[Extension::ParseEntry::MEMBER_CLASS]).to equal(union.member_type(:string))
          expect(entry[Extension::ParseEntry::PLAIN_MEMBER]).to be(true)
        end

        it 'does not treat a member class with its own #[]= as plain' do
          union = shape.member(:union).target
          union.member_type(:string).class_eval do
            define_method(:[]=) { |name, value| super(name, value) }
          end
          expect(described_class.parse_plan(union)['string'][Extension::ParseEntry::PLAIN_MEMBER]).to be(false)
        end
      end

      describe 'collection value plans' do
        it 'describe the member of a list for the builder and the reader' do
          list = shape.member(:sparse_list).target
          expect(described_class.collection_value_build_plan(list)).to eq([Schema::Shapes::Prelude::String, :scalar])
          expect(described_class.collection_value_parse_plan(list)).to eq([Schema::Shapes::Prelude::String, :scalar])
        end

        it 'describe the value of a map, not its key' do
          map = shape.member(:union_map).target
          expect(described_class.collection_value_build_plan(map)).to eq([map.value.target, :union])
          expect(described_class.collection_value_parse_plan(map)).to eq([map.value.target, :union])
        end
      end
    end
  end
end
