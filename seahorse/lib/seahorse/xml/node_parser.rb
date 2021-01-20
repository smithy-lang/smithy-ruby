# frozen_string_literal: true

module Seahorse
  module XML
    class NodeParser

      # @param [NawsXml::Node, String<XML>] xml
      def initialize(xml:)
        @node = xml.is_a?(NawsXml::Node) ? xml : Parser.parse(xml)
        @data = {}
      end

      # @return [Hash]
      attr_reader :data

      def parse_string(node_name:, key:)
        node = @node[node_name].first
        return if node.nil?
        @data[key] = string_value(node)
      end

      def parse_flat_list(node_name:, key:)
        @data[key] = []
        @node[node_name].each do |node|
          # need to support non-flat lists
          # need to support multiple formats, Time.parse, Float(), etc
          # need to support nested nodes
          yield
          @data[key] << node.text.to_s
        end
      end
    end
  end
end
