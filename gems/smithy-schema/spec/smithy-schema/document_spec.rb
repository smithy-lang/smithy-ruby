# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Schema
    describe Document do
      # correct handles integer, blob? union? time?
      let(:runtime_shape) do
        Struct.new(:string, keyword_init: true) do
          include Smithy::Schema::Structure
        end
      end

      let(:schema_shape) do
        string_shape = Shapes::StringShape.new(id: 'smithy.api#String')
        shape = Shapes::StructureShape.new(id: 'smithy.ruby.tests#Structure')
        shape.add_member(:string, 'stringMember', string_shape)
        shape.type = runtime_shape
        shape
      end

      let(:aggregate_runtime_shape) do
        Struct.new(
          :string,
          :list,
          :foo_map,
          :structure,
          keyword_init: true
        ) do
          include Smithy::Schema::Structure
        end
      end

      let(:aggregate_schema_shape) do
        string_shape = Shapes::StringShape.new(id: 'smithy.api#String')
        list_shape = Shapes::ListShape.new(id: 'smithy.ruby.tests#List')
        list_shape.set_member(Shapes::Prelude::String)
        map_shape = Shapes::MapShape.new(id: 'smithy.ruby.tests#Map')
        map_shape.set_key(Shapes::Prelude::String)
        map_shape.set_value(list_shape)
        shape = Shapes::StructureShape.new(id: 'smithy.ruby.tests#Structure')
        shape.add_member(:string, 'stringMember', string_shape)
        shape.add_member(:list, 'listMember', list_shape)
        shape.add_member(:foo_map, 'mapMember', map_shape)
        shape.add_member(:structure, 'structureMember', shape)
        shape.type = aggregate_runtime_shape
        shape
      end

      context 'untyped document' do
        subject { Document.new('foo') }

        describe '#initialize' do
          it 'sets given data' do
            expect(subject.data).to eq('foo')
          end

          it 'defaults discriminator to nil' do
            expect(subject.discriminator).to be_nil
          end
        end

        describe '#[]' do
          subject { Document.new({ foo: 'bar' }) }

          it 'returns member value' do
            expect(subject[:foo]).to eq('bar')
          end

          it 'returns nil when member key is not applicable' do
            expect(subject['baz']).to be_nil
          end
        end

        describe '#discriminator' do
          it 'is not set' do
            expect(subject.discriminator).to be_nil
          end
        end

        describe '#as_typed' do
          it 'converts document as runtime shape' do
            typed_shape = Document.new({ string: 'foo' }).as_typed(schema_shape)
            expect(typed_shape).to be_a(runtime_shape)
            expect(typed_shape[:string]).to eq('foo')
          end

          it 'raises when invalid schema is given' do
            invalid_schema = Shapes::StringShape.new(id: 'smithy.api#String')
            expect do
              subject.as_typed(invalid_schema)
            end.to raise_error(ArgumentError)
          end

          it 'raises when document cannot be converted' do
            expect do
              subject.as_typed(schema_shape)
            end.to raise_error(ArgumentError)
          end
        end

        describe '#as_json' do
          # TODO
        end
      end

      context 'typed document' do
        let(:typed_shape) do
          aggregate_runtime_shape.new(
            string: 'foo',
            list: %w[Item1 Item2],
            foo_map: { foo: ['Thing'] },
            structure: { list: ['AnotherThing'] }
          )
        end

        subject { Document.new(typed_shape, aggregate_schema_shape) }

        context 'when runtime shape is the input' do
          describe '#initialize' do
            it 'sets data' do
              expected_data = {
                'stringMember' => 'foo',
                'listMember' => %w[Item1 Item2],
                'mapMember' => { 'foo' => ['Thing'] },
                'structureMember' => { 'listMember' => ['AnotherThing'] }
              }
              expect(subject.data).to eq(expected_data)
            end

            it 'sets discriminator' do
              expect(subject.discriminator).to be(schema_shape.id)
            end

            it 'raises when no schema is given' do
              expect do
                Document.new(typed_shape)
              end.to raise_error(ArgumentError)
            end

            it 'raises when unable to deconstruct data with schema' do
              invalid_schema = Shapes::StringShape.new(id: 'smithy.api#String')
              expect do
                Document.new(typed_shape, invalid_schema)
              end.to raise_error(ArgumentError)
            end
          end

          describe '#[]' do
            it 'returns member value' do
              expect(subject['stringMember']).to eq('foo')
            end

            it 'returns nil when member key is not applicable' do
              expect(subject['someInvalidMember']).to be_nil
            end
          end

          describe '#discriminator' do
            it 'is not nil' do
              expect(subject.discriminator).not_to be_nil
            end
          end

          describe '#as_typed' do
            it 'converts document as a runtime shape' do
              typed_shape = subject.as_typed(schema_shape)
              expect(typed_shape).to be_a(runtime_shape)
              expect(typed_shape[:string]).to eq('foo')
            end

            it 'raises when unable to convert as runtime shape' do
              # TODO
            end
          end

          describe '#as_json' do
            # TODO
          end
        end

        context 'when json is given' do
          # TODO
        end
      end
    end
  end
end
