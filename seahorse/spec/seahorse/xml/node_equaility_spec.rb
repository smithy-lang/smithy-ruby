# frozen_string_literal: true
#
require_relative '../../../lib/seahorse/xml/node_equality'

module Seahorse
  module XML
    describe :be_equal_xml do

      it 'is true when the node is self' do
        actual = Node.new('name')
        expect(actual).to be_equal_xml(actual)
      end

      it 'is true when name matches' do
        actual = Node.new('name')
        expected = Node.new('name')
        expect(actual).to be_equal_xml(expected)
      end

      it 'is false when name does not match' do
        actual = Node.new('name')
        expected = Node.new('different name')
        expect(actual).not_to be_equal_xml(expected)
      end

      it 'is true when text matches' do
        actual = Node.new('name', 'text')
        expected = Node.new('name', 'text')
        expect(actual).to be_equal_xml(expected)
      end

      it 'is false when text does not match' do
        actual = Node.new('name', 'text')
        expected = Node.new('name', 'different text')
        expect(actual).not_to be_equal_xml(expected)
      end

      it 'is true when attributes match' do
        actual = Node.new('name')
        actual.attributes['attr-1'] = 'value-1'

        expected = Node.new('name')
        expected.attributes['attr-1'] = 'value-1'

        expect(actual).to be_equal_xml(expected)
      end

      it 'is false when attributes do not match' do
        actual = Node.new('name')
        actual.attributes['attr-1'] = 'value-1'
        expected = Node.new('name')
        expect(actual).not_to be_equal_xml(expected)
      end

      it 'is false when number of children differs' do
        actual = Node.new('name')
        actual << Node.new('child')

        expected = Node.new('name')

        expect(actual).not_to be_equal_xml(expected)
      end

      it 'is true when children match' do
        actual = Node.new('name')
        actual << Node.new('child')

        expected = Node.new('name')
        expected << Node.new('child')

        expect(actual).to be_equal_xml(expected)
      end

      it 'is false when children do not match' do
        actual = Node.new('name')
        actual << Node.new('different child')

        expected = Node.new('name')
        expected << Node.new('child')

        expect(actual).not_to be_equal_xml(expected)
      end
    end
  end
end