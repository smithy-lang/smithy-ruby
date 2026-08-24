# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    module Shapes
      describe Shape do
        subject { Shape.new }

        describe '#initialize' do
          it 'defaults id to nil' do
            expect(subject.id).to be_nil
          end

          it 'can set id' do
            subject = Shape.new(id: 'my.namespace#ShapeId')
            expect(subject.id).to eq('my.namespace#ShapeId')
          end

          it 'can set name' do
            subject = Shape.new(name: 'ShapeName')
            expect(subject.name).to eq('ShapeName')
          end

          it 'defaults traits to empty hash' do
            expect(subject.traits).to eq({})
          end

          it 'can set traits' do
            subject = Shape.new(traits: { 'trait' => 'value' })
            expect(subject.traits).to eq({ 'trait' => 'value' })
          end

          it 'can get and set metadata' do
            subject = Shape.new
            subject[:foo] = 'bar'
            expect(subject[:foo]).to eq('bar')
          end
        end
      end

      describe MemberShape do
        subject { MemberShape.new }

        it 'defaults shape to nil' do
          expect(subject.target).to be_nil
        end

        it 'can reference a shape' do
          shape = Shape.new
          subject = MemberShape.new(target: shape)
          expect(subject.target).to be(shape)
        end

        it 'stores a modeled member name' do
          subject = MemberShape.new(name: 'foo')
          expect(subject.name).to eq('foo')
        end

        it 'defaults traits to empty hash' do
          expect(subject.traits).to eq({})
        end

        it 'can get and set metadata' do
          subject = MemberShape.new
          subject[:foo] = 'bar'
          expect(subject[:foo]).to eq('bar')
        end
      end

      describe ServiceShape do
        subject { ServiceShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        it 'is enumerable' do
          expect(subject).to be_kind_of(Enumerable)
        end

        describe '#initialize' do
          it 'yields itself' do
            yielded = nil
            subject = ServiceShape.new { |schema| yielded = schema }
            expect(yielded).to be(subject)
          end

          it 'can set a name' do
            subject = ServiceShape.new(name: 'ServiceName')
            expect(subject.name).to eq('ServiceName')
          end

          it 'can set a version' do
            subject = ServiceShape.new(version: '2015-01-01')
            expect(subject.version).to eq('2015-01-01')
          end

          it 'defaults operations to empty hash' do
            expect(subject.operations).to be_empty
          end
        end

        describe '#each' do
          it 'enumerates over operations' do
            operation_shape = Shapes::OperationShape.new
            subject.add_operation(:operation, operation_shape)
            expect { |b| subject.each(&b) }
              .to yield_successive_args([:operation, operation_shape])
          end
        end

        describe '#add_operation' do
          it 'adds an operation' do
            operation_shape = Shapes::OperationShape.new
            subject.add_operation(:operation, operation_shape)
            expect(subject.operations[:operation]).to be(operation_shape)
          end
        end

        describe '#operation' do
          it 'raises an ArgumentError for unknown operations' do
            expect do
              subject.operation(:unknown)
            end.to raise_error(ArgumentError, 'unknown operation :unknown')
          end

          it 'returns the operation' do
            operation_shape = Shapes::OperationShape.new
            subject.add_operation(:operation, operation_shape)
            expect(subject.operation(:operation)).to be(operation_shape)
          end
        end

        describe '#operation_names' do
          it 'defaults to an empty array' do
            expect(subject.operation_names).to eq([])
          end

          it 'provides operation names' do
            subject.add_operation(:operation, Shapes::OperationShape.new)
            expect(subject.operation_names).to eq([:operation])
          end
        end
      end

      describe OperationShape do
        subject { OperationShape.new }

        let(:member_shape) { MemberShape.new(target: StructureShape.new) }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        describe '#initialize' do
          it 'can set a name' do
            subject = OperationShape.new(name: 'OperationName')
            expect(subject.name).to eq('OperationName')
          end

          it 'input defaults to nil' do
            expect(subject.input).to be(nil)
          end

          it 'output defaults to nil' do
            expect(subject.output).to be(nil)
          end

          it 'errors defaults to empty array' do
            expect(subject.errors).to be_empty
          end
        end

        context '#input' do
          it 'can get the input' do
            subject = OperationShape.new(input: member_shape)
            expect(subject.input).to be(member_shape)
          end
        end

        context '#output' do
          it 'can get the output' do
            subject = OperationShape.new(output: member_shape)
            expect(subject.output).to be(member_shape)
          end
        end

        context '#errors' do
          it 'can get a list of errors' do
            subject = OperationShape.new(errors: [member_shape])
            expect(subject.errors).to eq([member_shape])
          end
        end
      end

      describe BigDecimalShape do
        subject { BigDecimalShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe BlobShape do
        subject { BlobShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe BooleanShape do
        subject { BooleanShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe DocumentShape do
        subject { DocumentShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe EnumShape do
        subject { EnumShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        it 'defaults members to empty hash' do
          expect(subject.members).to be_empty
        end

        describe '#add_member' do
          it 'adds a member reference' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.members[:foo]).to be_kind_of(MemberShape)
          end
        end

        describe '#member?' do
          it 'returns true if member exists' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.member?(:foo)).to be(true)
          end
        end

        describe '#member' do
          it 'returns the member' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.member(:foo)).to be_kind_of(MemberShape)
          end
        end
      end

      describe IntegerShape do
        subject { IntegerShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe IntEnumShape do
        subject { IntEnumShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        it 'defaults members to empty hash' do
          expect(subject.members).to be_empty
        end

        describe '#add_member' do
          it 'adds a member reference' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.members[:foo]).to be_kind_of(MemberShape)
          end
        end

        describe '#member?' do
          it 'returns true if member exists' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.member?(:foo)).to be(true)
          end
        end

        describe '#member' do
          it 'returns the member' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.member(:foo)).to be_kind_of(MemberShape)
          end
        end
      end

      describe FloatShape do
        subject { FloatShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe ListShape do
        subject { ListShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        describe '#initialize' do
          it 'defaults member to nil' do
            expect(subject.member).to be(nil)
          end
        end

        describe '#member accessor' do
          it 'gets and sets a member' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.member = member_shape
            expect(subject.member).to eq(member_shape)
          end
        end
      end

      describe MapShape do
        subject { MapShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        describe '#initialize' do
          it 'key defaults to nil' do
            expect(subject.key).to be(nil)
          end

          it 'value defaults to nil' do
            expect(subject.value).to be(nil)
          end
        end

        describe '#key accessor' do
          it 'gets and sets a key' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.key = member_shape
            expect(subject.key).to eq(member_shape)
          end
        end

        describe '#value accessor' do
          it 'gets and sets a value' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.value = member_shape
            expect(subject.value).to eq(member_shape)
          end
        end
      end

      describe StringShape do
        subject { StringShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe StructureShape do
        subject { StructureShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        it 'defaults members to empty hash' do
          expect(subject.members).to be_empty
        end

        describe '#type accessor' do
          it 'can get and set a type class' do
            subject.type = Class
            expect(subject.type).to be(Class)
          end
        end

        describe '#add_member' do
          it 'adds a member reference' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.members[:foo]).to be_kind_of(MemberShape)
          end
        end

        describe '#member?' do
          it 'returns true if member exists' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.member?(:foo)).to be(true)
          end
        end

        describe '#member' do
          it 'returns the member' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, member_shape)
            expect(subject.member(:foo)).to be_kind_of(MemberShape)
          end
        end
      end

      describe TimestampShape do
        subject { TimestampShape.new }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end
      end

      describe UnionShape do
        subject { UnionShape.new }

        let(:union_type) { Class }

        it 'is a subclass of Shape' do
          expect(subject).to be_kind_of(Shape)
        end

        it 'defaults members to empty hash' do
          expect(subject.members).to be_empty
        end

        it 'defaults member_types to empty hash' do
          expect(subject.member_types).to be_empty
        end

        it 'defaults members_by_type to empty hash' do
          expect(subject.members_by_type).to be_empty
        end

        describe '#type accessor' do
          it 'can get and set a type class' do
            subject.type = Class
            expect(subject.type).to be(Class)
          end
        end

        describe '#add_member' do
          it 'adds a member with its type' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, union_type, member_shape)
            expect(subject.members[:foo]).to be(member_shape)
            expect(subject.member_types[:foo]).to be(union_type)
            expect(subject.members_by_type[union_type]).to eq([:foo, member_shape])
          end
        end

        describe '#member?' do
          it 'returns true if member exists' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, union_type, member_shape)
            expect(subject.member?(:foo)).to be(true)
          end
        end

        describe '#member' do
          it 'returns the member' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, union_type, member_shape)
            expect(subject.member(:foo)).to be_kind_of(MemberShape)
          end
        end

        describe '#member_type?' do
          it 'returns true if member type exists' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, union_type, member_shape)
            expect(subject.member_type?(:foo)).to be(true)
          end
        end

        describe '#member_type' do
          it 'returns the member type' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, union_type, member_shape)
            expect(subject.member_type(:foo)).to eq(union_type)
          end
        end

        describe '#member_by_type?' do
          it 'returns true if member by type exists' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, union_type, member_shape)
            expect(subject.member_by_type?(union_type)).to be(true)
          end
        end

        describe '#member_by_type' do
          it 'returns the member by type' do
            member_shape = MemberShape.new(target: StringShape.new)
            subject.add_member(:foo, union_type, member_shape)
            expect(subject.member_by_type(union_type)).to eq([:foo, member_shape])
          end
        end
      end

      describe Prelude do
        it 'is a module' do
          expect(Prelude).to be_kind_of(Module)
        end

        it 'has prelude shapes' do
          expect(Prelude::BigDecimal).to be_kind_of(BigDecimalShape)
          expect(Prelude::BigInteger).to be_kind_of(IntegerShape)
          expect(Prelude::Blob).to be_kind_of(BlobShape)
          expect(Prelude::Boolean).to be_kind_of(BooleanShape)
          expect(Prelude::Byte).to be_kind_of(IntegerShape)
          expect(Prelude::Document).to be_kind_of(DocumentShape)
          expect(Prelude::Double).to be_kind_of(FloatShape)
          expect(Prelude::Float).to be_kind_of(FloatShape)
          expect(Prelude::Integer).to be_kind_of(IntegerShape)
          expect(Prelude::Long).to be_kind_of(IntegerShape)
          expect(Prelude::PrimitiveBoolean).to be_kind_of(BooleanShape)
          expect(Prelude::PrimitiveByte).to be_kind_of(IntegerShape)
          expect(Prelude::PrimitiveDouble).to be_kind_of(FloatShape)
          expect(Prelude::PrimitiveFloat).to be_kind_of(FloatShape)
          expect(Prelude::PrimitiveInteger).to be_kind_of(IntegerShape)
          expect(Prelude::PrimitiveShort).to be_kind_of(IntegerShape)
          expect(Prelude::PrimitiveLong).to be_kind_of(IntegerShape)
          expect(Prelude::Short).to be_kind_of(IntegerShape)
          expect(Prelude::String).to be_kind_of(StringShape)
          expect(Prelude::Timestamp).to be_kind_of(TimestampShape)
          expect(Prelude::Unit).to be_kind_of(StructureShape)
        end
      end
    end
  end
end
