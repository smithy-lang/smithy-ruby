# frozen_string_literal: true

require 'rexml/document'
require 'rexml/streamlistener'

module Smithy
  module Xml
    class Parser
      # @api private
      class RexmlEngine
        include REXML::StreamListener

        def initialize(stack)
          @stack = stack
          @depth = 0
        end

        def parse(xml)
          source = REXML::Source.new(xml)
          REXML::Parsers::StreamParser.new(source, self).parse
        rescue REXML::ParseException => e
          @stack.error(e.message)
        end

        def tag_start(name, attrs)
          @depth += 1
          @stack.start_element(name)
          attrs.each do |attr|
            @stack.attr(*attr)
          end
        end

        def text(value)
          @stack.text(value) if @depth.positive?
        end

        def tag_end(*_ignored)
          @stack.end_element
          @depth -= 1
        end
      end
    end
  end
end
