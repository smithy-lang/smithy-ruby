# frozen_string_literal: true

require 'smithy-schema'

require_relative 'smithy-xml/builder'
require_relative 'smithy-xml/codec'
require_relative 'smithy-xml/doc_builder'
require_relative 'smithy-xml/extension'
require_relative 'smithy-xml/parser'

module Smithy
  # Smithy::Xml is a purpose-built set of utilities for working with XML.
  module Xml
    VERSION = File.read(File.expand_path('../VERSION', __dir__.to_s)).strip

    # Raised when an XML parsing error occurs.
    class ParseError < StandardError
      def initialize(msg, line, column)
        @line = line
        @column = column
        super(msg)
      end

      # @return [Integer, nil]
      attr_reader :line

      # @return [Integer, nil]
      attr_reader :column
    end
  end
end
