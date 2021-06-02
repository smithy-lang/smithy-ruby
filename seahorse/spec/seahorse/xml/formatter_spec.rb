# frozen_string_literal: true

module Seahorse
  module XML
    describe Formatter do
      describe '#initialize' do
        it 'raises when indent is not a String' do
          expect { Formatter.new(indent: 1) }.to raise_error(ArgumentError)
        end
      end

      describe '#format' do
        it 'generates xml without whitespaces by default' do
          node = Node.new('name', Node.new('child', 'text'))
          node.attributes['key'] = 'value'
          expect(Formatter.new.format(node)).to eq('<name key="value"><child>text</child></name>')
        end

        it 'accepts an indent that is used to pretty-format the xml' do
          node = Node.new('name', Node.new('child', 'text'))
          node.attributes['key'] = 'value'
          expect(Formatter.new(indent: '  ').format(node)).to eq(<<~XML)
            <name key="value">
              <child>text</child>
            </name>
          XML
        end

        it 'can format an empty node' do
          node = Node.new('name')
          expect(Formatter.new.format(node)).to eq('<name/>')
        end

        it 'escapes xml attribute values' do
          node = Node.new('node')
          node.attributes['key'] = 'v&lue'
          expect(Formatter.new(indent: '  ').format(node)).to eq(<<~XML)
            <node key="v&amp;lue"/>
          XML
        end

        it 'escapes xml text' do
          node = Node.new('node')
          node << '<text>'
          expect(Formatter.new(indent: '  ').format(node)).to eq(<<~XML)
            <node>&lt;text&gt;</node>
          XML
        end

        it 'can format deeply nested nodes' do
          node = Node.new('name', Node.new('child1', Node.new('child2', Node.new('child3'))))
          expect(Formatter.new(indent: '  ').format(node)).to eq(<<~XML)
            <name>
              <child1>
                <child2>
                  <child3/>
                </child2>
              </child1>
            </name>
          XML
        end
      end
    end
  end
end
