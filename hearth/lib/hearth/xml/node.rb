# frozen_string_literal: true

module Hearth
  module XML
    # A class used to represent an XML node.
    # @api private
    class Node
      BOTH_TYPES = 'Nodes may not have both text and child nodes'

      # @param [String] name
      def initialize(name, *children, attributes: {})
        @name = name
        @attributes = attributes
        @child_nodes = []
        @child_node_map = {}
        @text = []
        append(*children)
      end

      # @return [String]
      attr_reader :name

      # @return [Hash<String, String>]
      attr_reader :attributes

      def <<(*children)
        children.flatten.each do |child|
          case child
          when Node
            raise ArgumentError, BOTH_TYPES unless @text.empty?

            @child_nodes << child
            @child_node_map[child.name] ||= []
            @child_node_map[child.name] << child
          when String
            raise ArgumentError, BOTH_TYPES unless @child_nodes.empty?

            @text << child
          else
            raise ArgumentError,
                  "expected Hearth::XML::Node or String, got #{child.class}"
          end
        end
      end
      alias append <<

      # @return [String, nil]
      def text
        @text.empty? ? nil : @text.join
      end

      # @param [String] node_name
      # @return [Array<Node>]
      def [](node_name)
        children(node_name)
      end

      # @overload children()
      #   @return [Array<Node>] Returns an array of all child nodes.
      # @overload children(child_name)
      #   @param [String] child_name
      #   @return [Array<Node>] Returns an array of child nodes with the given
      #     name.
      def children(*args)
        nodes =
          case args.count
          when 0 then @child_nodes
          when 1 then @child_node_map.fetch(args.first, [])
          else raise ArgumentError, 'expected 0 or 1 arguments'
          end
        yield(nodes) if block_given? && !nodes.empty?
        nodes
      end
      alias child_nodes children

      # @return [Boolean]
      def empty?
        @child_nodes.empty? && @text.empty?
      end

      # @return [Array<String>]
      def child_node_names
        @child_node_map.keys
      end

      # @return [Boolean]
      def child_node?(name)
        @child_node_map.key?(name)
      end

      # @yield [child]
      # @yieldparam child [Node]
      # @return [Node, nil]
      def child(child_name)
        child = @child_node_map[child_name]&.first
        yield(child) if block_given? && !child.nil?
        child
      end
      alias at child

      # @yield [text]
      # @yieldparam text [String]
      # @return [String, nil]
      def text_at(child_name)
        text = @child_node_map[child_name].first&.text
        yield(text) if block_given? && !text.nil?
        text
      end

      # @option options [String] :indent ('')
      #   When `indent` is non-empty whitespace, then the XML will
      #   be pretty-formatted with each level of nodes indented by
      #   `indent`.
      # @return [String<XML>]
      def to_xml(indent: '')
        Formatter.new(indent: indent).format(self)
      end
      alias to_str to_xml
      alias to_s to_xml
    end
  end
end
