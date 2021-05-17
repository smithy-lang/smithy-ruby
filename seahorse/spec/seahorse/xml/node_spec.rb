# frozen_string_literal: true

require 'seahorse/xml/node'

module Seahorse
  module XML
    describe Node do
      context '#initialize' do
        it 'accpets a name with text arguments' do
          node = Node.new('name', 'te', 'xt')
          expect(node.name).to eq('name')
          expect(node.text).to eq('text')
        end

        it 'accpets a name with an array of text' do
          node = Node.new('name', ['te', 'xt'])
          expect(node.name).to eq('name')
          expect(node.text).to eq('text')
        end

        it 'flattens text arguments' do
          node = Node.new('name', ['te'], 'xt')
          expect(node.name).to eq('name')
          expect(node.text).to eq('text')
        end

        it 'accepts a name with child node arguments' do
          child1 = Node.new('child1')
          child2 = Node.new('child1')
          node = Node.new('name', child1, child2)
          expect(node.child_nodes).to eq([child1, child2])
        end

        it 'accepts a name with array of child nodes' do
          child1 = Node.new('child1')
          child2 = Node.new('child1')
          node = Node.new('name', [child1, child2])
          expect(node.child_nodes).to eq([child1, child2])
        end

        it 'flattens child node arguments' do
          child1 = Node.new('child1')
          child2 = Node.new('child1')
          node = Node.new('name', [child1], child2)
          expect(node.child_nodes).to eq([child1, child2])
        end

        it 'raises an error when given text and child nodes' do
          expect do
            Node.new('name', 'text', Node.new('child'))
          end.to raise_error(ArgumentError)
        end
      end

      context '#name' do
        it 'returns the node name' do
          expect(Node.new('name').name).to eq('name')
        end
      end

      context '#attributes' do
        it 'defaults to an empty hash' do
          expect(Node.new('name').attributes).to eq({})
        end

        it 'is a hash of xml node attributes' do
          node = Node.new('name')
          node.attributes['foo'] = 'bar'
          expect(node.attributes).to eq('foo' => 'bar')
        end
      end

      context '#text' do
        it 'returns nil for a new node' do
          node = Node.new('name')
          expect(node.text).to be(nil)
        end

        it 'returns the text of a node' do
          node = Node.new('name')
          node << 'abc'
          expect(node.text).to eq('abc')
        end

        it 'joins multiple text nodes' do
          node = Node.new('name')
          node << 'abc'
          node << 'mno'
          node << 'xyz'
          expect(node.text).to eq('abcmnoxyz')
        end
      end

      context '#<<' do
        it 'appends child text' do
          node = Node.new('name')
          node << 'abc'
          node << 'xyz'
          expect(node.text).to eq('abcxyz')
        end

        it 'appends child nodes' do
          child = Node.new('child')
          node = Node.new('name')
          node << child
          expect(node.child_nodes).to eq([child])
        end

        it 'it aliased to #append' do
          node = Node.new('name')
          node.append('text')
          expect(node.text).to eq('text')
        end

        it 'raises ArgumentError when appending non-text/non-node' do
          node = Node.new('name')
          expect do
            node << nil
          end.to raise_error(ArgumentError, 'expected Seahorse::XML::Node or String, got NilClass')
        end

        it 'raises when appending a child node to node with text' do
          node = Node.new('name')
          node << 'text'
          expect do
            node << Node.new('child')
          end.to raise_error('Nodes may not have both text and child nodes')
        end

        it 'raises when appending text to a node with a child node' do
          node = Node.new('name')
          node << Node.new('child')
          expect do
            node << 'text'
          end.to raise_error('Nodes may not have both text and child nodes')
        end
      end

      context '#[]' do
        it 'returns an array of child-nodes with the given name' do
          node = Node.new('name')
          child1 = Node.new('child')
          child2 = Node.new('child')
          node << child1
          node << child2
          expect(node['child']).to eq([child1, child2])
        end

        it 'returns an array even when there is only 1 child' do
          node = Node.new('name')
          child = Node.new('child')
          node << child
          expect(node['child']).to eq([child])
        end

        it 'returns an empty array when there are no child nodes' do
          node = Node.new('name')
          expect(node['child']).to eq([])
        end
      end

      context '#child_node_names' do
        it 'returns an array of child node names' do
          node = Node.new('name')
          node << Node.new('child1')
          node << Node.new('child2')
          node << Node.new('child2')
          expect(node.child_node_names).to eq(%w(child1 child2))
        end

        it 'returns an empty array for an empty node' do
          expect(Node.new('name').child_node_names).to eq([])
        end
      end

      context '#child_node?' do
        it 'returns false if there is no child-node with the given name' do
          node = Node.new('name')
          expect(node.child_node?('child')).to be(false)
        end

        it 'returns false if the node does not have a child with the given name' do
          node = Node.new('name')
          node << Node.new('other-child')
          expect(node.child_node?('child')).to be(false)
        end

        it 'returns true if the node has a child node with the given name' do
          node = Node.new('name')
          node << Node.new('child')
          expect(node.child_node?('child')).to be(true)
        end
      end

      context '#child_nodes' do
        it 'returns an empty array for an empty node' do
          node = Node.new('name')
          expect(node.child_nodes).to eq([])
        end

        it 'returns an ordered array of child nodes' do
          child1 = Node.new('name1')
          child2 = Node.new('name2')
          child3 = Node.new('name1')
          node = Node.new('name')
          node << child1
          node << child2
          node << child3
          expect(node.child_nodes).to eq([child1, child2, child3])
          node = Node.new('name')
          node.append(child1, child2, child3)
          expect(node.child_nodes).to eq([child1, child2, child3])
        end
      end

      context '#empty?' do
        it 'returns true when the node has not text and no child nodes' do
          expect(Node.new('name').empty?).to be(true)
        end

        it 'returns false when the node has text' do
          node = Node.new('name')
          node << 'text'
          expect(node.empty?).to be(false)
        end

        it 'returns false when the node has a child node' do
          node = Node.new('name')
          node << Node.new('child')
          expect(node.empty?).to be(false)
        end
      end

      context '#to_xml' do
        it 'returns the node as an XML string' do
          node = Node.new('name')
          expect(node.to_xml).to eq('<name/>')
        end

        it 'can be pretty-formatted' do
          node = Node.new('parent')
          node.append(Node.new('child'))
          expect(node.to_xml(indent: '  ')).to eq(<<~XML)
            <parent>
              <child/>
            </parent>
          XML
        end

        it 'is aliased to #to_str' do
          node = Node.new('name')
          expect(node.to_str).to eq('<name/>')
        end

        it 'is aliased to #to_s' do
          node = Node.new('name')
          expect(node.to_s).to eq('<name/>')
        end
      end
    end
  end
end
