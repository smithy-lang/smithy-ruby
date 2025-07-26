# frozen_string_literal: true

require_relative 'parser/stack'

module Smithy
  module Xml
    # @api private
    class Parser
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

      def initialize(options = {})
        @engine = options[:engine] || self.class.engine
      end

      # Parses the XML document, returning a parsed structure.
      #
      # If you pass a block, this will yield for XML elements that are not modeled in the schema.
      #
      #   parser.parse(xml) do |path, value|
      #     puts "unhandled: #{path.join('/')} - #{value}"
      #   end
      #
      # The purpose of the unhandled callback block is to allow callers to access values
      # such as a request ID that are part of the XML body but not part of modeling.
      #
      # @param [ShapeRef, Shape] shape
      # @param [String] bytes
      # @param [Object, nil] target (nil)
      # @return [Object]
      def parse(shape, bytes, target = nil, &)
        ref = shape.is_a?(ShapeRef) ? shape : ShapeRef.new(shape: shape)
        bytes = '<xml/>' if bytes.nil? || bytes.empty?
        stack = Stack.new(ref, target, &)
        @engine.new(stack).parse(bytes.to_s)
        stack.result
      end

      class << self

        # @param [Symbol, Class] engine
        #   Must be one of the following values:
        #
        #   * :ox
        #   * :oga
        #   * :libxml
        #   * :nokogiri
        #   * :rexml
        #
        def engine=(engine)
          @engine = engine.is_a?(Class) ? engine : load_engine(engine)
        end

        # @return [Class] Returns the default parsing engine.
        #   One of:
        #
        #   * {OxEngine}
        #   * {OgaEngine}
        #   * {LibxmlEngine}
        #   * {NokogiriEngine}
        #   * {RexmlEngine}
        #
        def engine
          set_default_engine unless @engine
          @engine
        end

        def set_default_engine
          %i[ox oga libxml nokogiri rexml].each do |name|
            @engine ||= try_load_engine(name)
          end
          return if @engine

          raise 'Unable to find a compatible xml library. ' \
                'Ensure that you have installed or added to your Gemfile one of: ' \
                'ox, oga, libxml, nokogiri or rexml'
        end

        private

        def try_load_engine(name)
          load_engine(name)
        rescue LoadError
          false
        end

        def load_engine(name)
          require "smithy-xml/parser/#{name}_engine"
          const_name = "#{name[0].upcase}#{name[1..]}Engine"
          const_get(const_name)
        end
      end

      set_default_engine
    end
  end
end
