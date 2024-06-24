# frozen_string_literal: true

module Hearth
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
          expect(Formatter.new.format(node))
            .to eq('<name key="value"><child>text</child></name>')
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

        context 'End of line characters' do
          # human readable input is tricky for these - so use a base64 encoded
          # string to ensure we get exactly what should be tested
          it 'encodes line feeds' do
            # "\n \n"
            input = Base64.decode64('CiAK').force_encoding(Encoding::UTF_8)
            node = Node.new('node', input)
            result = Formatter.new.format(node)
            expect(result).to include('&#xA; &#xA;')
          end

          it 'encodes line feeds and carriage returns' do
            # "a\r\n b\n c\r"
            input = Base64.decode64('YQ0KIGIKIGMN')
                          .force_encoding(Encoding::UTF_8)
            node = Node.new('node', input)
            result = Formatter.new.format(node)
            expect(result).to include('a&#xD;&#xA; b&#xA; c&#xD;')
          end

          it 'encodes next lines' do
            # "a\r\u0085 b\u0085"
            input = Base64.decode64('YQ3ChSBiwoU=')
                          .force_encoding(Encoding::UTF_8)
            node = Node.new('node', input)
            result = Formatter.new.format(node)
            expect(result).to include('a&#xD;&#x85; b&#x85;')
          end

          it 'encodes line separators' do
            # "a\r\u2028 b\u0085 c\u2028"
            input = Base64.decode64('YQ3igKggYsKFIGPigKg=')
                          .force_encoding(Encoding::UTF_8)
            node = Node.new('node', input)
            result = Formatter.new.format(node)
            expect(result).to include('a&#xD;&#x2028; b&#x85; c&#x2028;')
          end
        end

        it 'can format deeply nested nodes' do
          node = Node.new('name',
                          Node.new('child1',
                                   Node.new('child2', Node.new('child3'))))
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
