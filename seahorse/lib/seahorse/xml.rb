# frozen_string_literal: true

require_relative 'xml/formatter'
require_relative 'xml/node_parser'
require_relative 'xml/node'
require_relative 'xml/parse_error'

require 'rexml'

module Seahorse
  # Seahorse::XML is a purpose-built set of utilities for working with
  # XML. It does not support many/most features of generic XML
  # parsing and serialization.
  # @api private
  module XML

    class << self

      # @param [String] xml
      # @return [Node]
      def parse(xml)
        doc = REXML::Document.new(xml.strip)
        raise "no XML element found: #{xml.inspect}" unless doc.root
        parse_node(doc.root)
      rescue StandardError => error
        raise ParseError.new(error)
      end

      private

      def parse_node(rexml_node)
        node = Node.new(rexml_node.name)
        apply_attributes(node, rexml_node)
        apply_child_nodes(node, rexml_node)
        apply_text(node, rexml_node)
        node
      end

      def apply_attributes(node, rexml_node)
        rexml_node.attributes.each_attribute do |attr|
          node.attributes[attr.name] = attr.value
        end
      end

      def apply_text(node, rexml_node)
        text = rexml_node.text
        return if text.nil?
        return if text.strip.empty? && !node.empty?
        node << text
      end

      def apply_child_nodes(node, rexml_node)
        rexml_node.each_element do |value|
          node.append(parse_node(value))
        end
      end

    end

  end
end
