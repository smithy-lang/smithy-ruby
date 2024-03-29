# frozen_string_literal: true

require 'stringio'

module Hearth
  module XML
    # A class used for formatting XML strings.
    # @api private
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
        text = escape(node.text, :text)
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
          " #{key}=#{escape(value, :attr)}"
        end.join
      end

      def escape(string, text_or_attr)
        string.to_s
              .encode(xml: text_or_attr)
              .gsub("\u{000D}", '&#xD;') # Carriage Return
              .gsub("\u{000A}", '&#xA;') # Line Feed
              .gsub("\u{0085}", '&#x85;') # Next Line
              .gsub("\u{2028}", '&#x2028;') # Line Separator
      end
    end
  end
end
