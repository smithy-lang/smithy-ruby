# frozen_string_literal: true

require 'ox'

module Seahorse
  module XML
    # @api private
    module Engines
      # @api private
      class OxEngine

        def parse(xml)
          doc = Ox.load(xml, skip: :skip_none)
          doc = doc.nodes.first if doc.is_a?(Ox::Document)
          raise "no XML element found: #{xml.inspect}" unless doc
          parse_node(doc)
        rescue StandardError => error
          raise ParseError.new(error)
        end

        def self.parse(xml)
          new.parse(xml)
        end

        private

        def parse_node(ox_node)
          node = Node.new(ox_node.name)
          ox_node.attributes.each_pair do |key, value|
            node.attributes[key.to_s] = value
          end
          parse_node_content(node, ox_node)
          node
        end

        def parse_node_content(node, ox_node)
          ox_node.nodes.each do |value|
            if value.is_a?(String)
              node << value
            else
              node << parse_node(value)
            end
          end
        end

      end
    end
  end
end
