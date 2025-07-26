# frozen_string_literal: true

require 'oga'

module Smithy
  module Xml
    class Parser
      # @api private
      class OgaEngine
        def initialize(stack)
          @stack = stack
          @depth = 0
        end

        def parse(xml)
          Oga.sax_parse_xml(self, xml, strict: true)
        rescue LL::ParserError => e
          raise ParseError.new(e.message, nil, nil)
        end

        def on_element(_namespace, name, attrs = {})
          @depth += 1
          @stack.start_element(name)
          attrs.each do |attr|
            @stack.attr(*attr)
          end
        end

        def on_text(value)
          @stack.text(value) if @depth.positive?
        end

        def after_element(*_ignored)
          @stack.end_element
          @depth -= 1
        end
      end
    end
  end
end
