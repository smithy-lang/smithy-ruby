# frozen_string_literal: true

require 'stringio'

module Seahorse
  module XML
    # A class used for formatting XML strings.
    class Formatter
      NEGATIVE_INDENT = 'indent must be greater than or equal to zero'

      # @param [String] indent
      #   When `indent` is non-empty whitespace, then the XML will
      #   be pretty-formatted with each level of nodes indented by
      #   `indent`.
      # @raise [ArgumentError] when indent is not a String.
      def initialize(indent: '')
        unless indent.is_a?(String)
          raise ArgumentError, "expected a String, got #{indent.class}"
        end

        @indent = indent
        @eol = indent.empty? ? '' : "\n"
      end

      # @param [Node] node
      # @return [String<XML>]
      def format(node)
        buffer = StringIO.new
        serialize(buffer, node, '')
        buffer.string
      end

      private

      def serialize(buffer, node, pad)
        return buffer.write(self_close_node(node, pad)) if node.empty?
        return buffer.write(text_node(node, pad)) if node.text

        serialize_nested(buffer, node, pad)
      end

      def self_close_node(node, pad)
        "#{pad}<#{node.name}#{attrs(node)}/>#{@eol}"
      end

      def text_node(node, pad)
        text = node.text.encode(xml: :text)
        "#{pad}<#{node.name}#{attrs(node)}>#{text}</#{node.name}>#{@eol}"
      end

      def serialize_nested(buffer, node, pad)
        buffer.write("#{pad}<#{node.name}#{attrs(node)}>#{@eol}")
        nested_pad = "#{pad}#{@indent}"
        node.child_nodes.each do |child_node|
          serialize(buffer, child_node, nested_pad)
        end
        buffer.write("#{pad}</#{node.name}>#{@eol}")
      end

      def attrs(node)
        node.attributes.map do |key, value|
          " #{key}=#{value.to_s.encode(xml: :attr)}"
        end.join
      end
    end
  end
end
