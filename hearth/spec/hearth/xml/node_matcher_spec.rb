# frozen_string_literal: true

require_relative '../../../lib/hearth/xml/node_matcher'

module Hearth
  module XML
    describe :match_xml_node do
      it 'is true when the node is self' do
        actual = Node.new('name')
        expect(actual).to match_xml_node(actual)
      end

      it 'is true when name matches' do
        actual = Node.new('name')
        expected = Node.new('name')
        expect(actual).to match_xml_node(expected)
      end

      it 'is false when name does not match' do
        actual = Node.new('name')
        expected = Node.new('different name')
        expect(actual).not_to match_xml_node(expected)
      end

      it 'is true when text matches' do
        actual = Node.new('name', 'text')
        expected = Node.new('name', 'text')
        expect(actual).to match_xml_node(expected)
      end

      it 'is false when text does not match' do
        actual = Node.new('name', 'text')
        expected = Node.new('name', 'different text')
        expect(actual).not_to match_xml_node(expected)
      end

      it 'is true when attributes match' do
        actual = Node.new('name')
        actual.attributes['attr-1'] = 'value-1'

        expected = Node.new('name')
        expected.attributes['attr-1'] = 'value-1'

        expect(actual).to match_xml_node(expected)
      end

      it 'is false when attributes do not match' do
        actual = Node.new('name')
        actual.attributes['attr-1'] = 'value-1'
        expected = Node.new('name')
        expect(actual).not_to match_xml_node(expected)
      end

      it 'is false when number of children differs' do
        actual = Node.new('name')
        actual << Node.new('child')

        expected = Node.new('name')

        expect(actual).not_to match_xml_node(expected)
      end

      it 'is true when children match' do
        actual = Node.new('name')
        actual << Node.new('child')

        expected = Node.new('name')
        expected << Node.new('child')

        expect(actual).to match_xml_node(expected)
      end

      it 'is false when children do not match' do
        actual = Node.new('name')
        actual << Node.new('different child')

        expected = Node.new('name')
        expected << Node.new('child')

        expect(actual).not_to match_xml_node(expected)
      end
    end
  end
end
