# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Xml
    describe Extension do
      let(:structure) { Schema::Shapes::StructureShape.new(name: 'Structure') }
      let(:element_member) do
        Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new,
          name: 'String'
        )
      end
      let(:attribute_member) do
        Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new,
          name: 'Status',
          traits: { 'smithy.api#xmlAttribute' => {} }
        )
      end

      describe '.structure_name' do
        it 'prefers an xmlName trait on the member shape' do
          member = Schema::Shapes::MemberShape.new(
            target: structure,
            traits: { 'smithy.api#xmlName' => 'RootElement' }
          )

          expect(described_class.structure_name(member)).to eq('RootElement')
          expect(member[:xml_structure_name]).to eq('RootElement')
        end

        it 'falls back to the target structure name' do
          expect(described_class.structure_name(structure)).to eq('Structure')
          expect(structure[:xml_structure_name]).to eq('Structure')
        end

        it 'memoizes the structure element name on shape metadata' do
          expect(described_class.structure_name(structure)).to be(described_class.structure_name(structure))
        end
      end

      describe '.wire_name' do
        it 'prefers xmlName when present' do
          member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::StringShape.new,
            name: 'String',
            traits: { 'smithy.api#xmlName' => 'NewString' }
          )

          expect(described_class.wire_name(member)).to eq('NewString')
          expect(member[:xml_name]).to eq('NewString')
        end

        it 'falls back to the provided default' do
          expect(described_class.wire_name(element_member)).to eq('String')
          expect(element_member[:xml_name]).to eq('String')
        end
      end

      describe '.members' do
        it 'returns ordered element and attribute members' do
          structure.add_member(:string, element_member)
          structure.add_member(:status, attribute_member)

          expect(described_class.members(structure)).to eq(
            elements: [[:string, element_member]],
            attributes: [[:status, attribute_member]]
          )
        end

        it 'memoizes the grouped members on shape metadata' do
          structure.add_member(:string, element_member)

          expect(described_class.members(structure)).to be(described_class.members(structure))
        end
      end

      describe '.member_index' do
        it 'indexes structure members by XML member name' do
          structure.add_member(:string, element_member)
          structure.add_member(:status, attribute_member)

          expect(described_class.member_index(structure)).to eq(
            'String' => [:string, element_member],
            'Status' => [:status, attribute_member]
          )
          expect(described_class.member_index(structure)).to be_frozen
          expect(element_member[:xml_name]).to eq('String')
          expect(attribute_member[:xml_name]).to eq('Status')
        end

        it 'memoizes the index on the shape metadata' do
          structure.add_member(:string, element_member)

          expect(described_class.member_index(structure)).to be(described_class.member_index(structure))
        end
      end

      describe '.namespace_attrs' do
        it 'builds default namespace attrs from xmlNamespace' do
          structure.traits['smithy.api#xmlNamespace'] = { 'uri' => 'https://example.com/ns' }

          expect(described_class.namespace_attrs(structure)).to eq('xmlns' => 'https://example.com/ns')
          expect(described_class.namespace_attrs(structure)).to be_frozen
        end

        it 'builds prefixed namespace attrs from xmlNamespace' do
          structure.traits['smithy.api#xmlNamespace'] = { 'uri' => 'https://example.com/ns', 'prefix' => 'smithy' }

          expect(described_class.namespace_attrs(structure)).to eq('xmlns:smithy' => 'https://example.com/ns')
        end

        it 'returns a memoized empty hash when no namespace is present' do
          expect(described_class.namespace_attrs(structure)).to eq({})
          expect(described_class.namespace_attrs(structure)).to be(described_class.namespace_attrs(structure))
          expect(described_class.namespace_attrs(structure)).to be_frozen
        end
      end
    end
  end
end
