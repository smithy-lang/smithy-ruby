# frozen_string_literal: true

require_relative '../spec_helper'

module Smithy
  module Xml
    describe Extension do
      let(:shape) { Schema::Shapes::StructureShape.new(name: 'Structure') }
      let(:element_member) do
        Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new,
          model_name: 'String'
        )
      end
      let(:attribute_member) do
        Schema::Shapes::MemberShape.new(
          target: Schema::Shapes::StringShape.new,
          model_name: 'Status',
          traits: { xml_attribute: {} }
        )
      end

      describe '.structure_name' do
        it 'prefers an xmlName trait on the member shape' do
          member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::StructureShape.new(name: 'Structure'),
            traits: { xml_name: 'RootElement' }
          )

          expect(described_class.structure_name(member)).to eq('RootElement')
        end

        it 'falls back to the target structure name' do
          member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::StructureShape.new(name: 'Structure')
          )

          expect(described_class.structure_name(member)).to eq('Structure')
        end
      end

      describe '.member_name' do
        it 'prefers xmlName when present' do
          member = Schema::Shapes::MemberShape.new(
            target: Schema::Shapes::StringShape.new,
            model_name: 'String',
            traits: { xml_name: 'NewString' }
          )

          expect(described_class.member_name(member, member.model_name)).to eq('NewString')
        end

        it 'falls back to the provided default' do
          expect(described_class.member_name(element_member, element_member.model_name)).to eq('String')
        end
      end

      describe '.members' do
        it 'returns ordered element and attribute members' do
          shape.add_member(:string, element_member)
          shape.add_member(:status, attribute_member)

          expect(described_class.members(shape)).to eq(
            elements: [[:string, element_member]],
            attributes: [[:status, attribute_member]]
          )
        end

        it 'memoizes the grouped members on shape metadata' do
          shape.add_member(:string, element_member)

          expect(described_class.members(shape)).to be(described_class.members(shape))
        end
      end

      describe '.member_index' do
        it 'indexes structure members by XML member name' do
          shape.add_member(:string, element_member)
          shape.add_member(:status, attribute_member)

          expect(described_class.member_index(shape)).to eq(
            'String' => [:string, element_member],
            'Status' => [:status, attribute_member]
          )
        end
      end

      describe '.namespace_attrs' do
        it 'builds default namespace attrs from xmlNamespace' do
          shape.traits[:xml_namespace] = { 'uri' => 'http://example.com/ns' }

          expect(described_class.namespace_attrs(shape)).to eq('xmlns' => 'http://example.com/ns')
          expect(described_class.namespace_attrs(shape)).to be_frozen
        end

        it 'builds prefixed namespace attrs from xmlNamespace' do
          shape.traits[:xml_namespace] = {
            'uri' => 'http://example.com/ns',
            'prefix' => 'smithy'
          }

          expect(described_class.namespace_attrs(shape)).to eq('xmlns:smithy' => 'http://example.com/ns')
        end

        it 'returns a memoized empty hash when no namespace is present' do
          expect(described_class.namespace_attrs(shape)).to eq({})
          expect(described_class.namespace_attrs(shape)).to be(described_class.namespace_attrs(shape))
          expect(described_class.namespace_attrs(shape)).to be_frozen
        end
      end
    end
  end
end
