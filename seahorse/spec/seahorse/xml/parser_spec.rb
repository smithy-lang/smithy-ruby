# frozen_string_literal: true

require 'seahorse/xml/parser'

module Seahorse
  module XML
    describe Parser do
      %w(ox_engine rexml_engine).each do |engine_method|
        context("Parser.#{engine_method}") do

          let(:parser) { Parser.new(engine: Parser.send(engine_method)) }

          it 'raises on an empty string' do
            expect do
              parser.parse('')
            end.to raise_error(ParseError, /no XML element found/)
          end

          it 'raises on a blank string' do
            expect do
              parser.parse('   ')
            end.to raise_error(ParseError, /no XML element found/)
          end

          it 'raises an error on unmatched elements' do
            expect do
              parser.parse('<abc></xyz>')
            end.to raise_error(ParseError)
          end

          it 'parses xml to a Node' do
            node = parser.parse('<root/>')
            expect(node.name).to eq('root')
            expect(node.attributes).to eq({})
            expect(node.text).to be_nil
            expect(node.child_nodes).to eq([])
          end

          it 'parses root attributes' do
            node = parser.parse('<root foo="bar" abc="mno"/>')
            expect(node.attributes).to eq('foo' => 'bar', 'abc' => 'mno')
          end

          it 'ignores xml instructions' do
            xml = <<~XML
              <?xml version="1.0" encoding="UTF-8"?>
              <root>value</root>
            XML
            node = parser.parse(xml)
            expect(node.text).to eq('value')
            expect(node.to_xml).to eq('<root>value</root>')
          end

          it 'parses nested nodes' do
            node = parser.parse('<root><foo><bar>value</bar></foo></root>')
            expect(node['foo'].first['bar'].first.text).to eq('value')
          end

          it 'parses whitespace as text if there are no child nodes' do
            node = parser.parse('<root> </root>')
            expect(node.text).to eq(' ')
            node = parser.parse('<root><node> </node></root>')
            expect(node['node'][0].text).to eq(' ')
          end

          it 'nested and duplicate nodes' do
            node = parser.parse(<<-XML.strip)
            <root>
              <foo>value1</foo>
              <foo>value2</foo>
              <bar><baz>value3</baz></bar>
              <bar><baz>value4</baz></bar>
              <bat><mno>value5</mno><mno>value6</mno></bat>
            </root>
            XML
            expect(node['foo'][0].text).to eq('value1')
            expect(node['foo'][1].text).to eq('value2')
            expect(node['bar'][0]['baz'][0].text).to eq('value3')
            expect(node['bar'][1]['baz'][0].text).to eq('value4')
            expect(node['bat'][0]['mno'][0].text).to eq('value5')
            expect(node['bat'][0]['mno'][1].text).to eq('value6')
          end

          it 'raises an error on nodes with mixed content' do
            expect do
              n = parser.parse('<root>abc<foo>bar</foo></root>')
            end.to raise_error(ParseError, 'Nodes may not have both text and child nodes')
          end

        end
      end
    end
  end
end
