# frozen_string_literal: true

require_relative 'xml/formatter'
require_relative 'xml/node_parser'
require_relative 'xml/node'
require_relative 'xml/parse_error'
require_relative 'xml/parser'

# Seahorse::XML is a purpose-built set of utilities for working with
# XML. It does not support many/most features of generic XML
# parsing and serialization.
# @api private
module Seahorse
  module XML
    class << self

      # @param [String] xml
      # @return [Node]
      def parse(xml, engine: Parser.default_engine)
        Parser.new(engine: engine).parse(xml)
      end

    end
  end
end
