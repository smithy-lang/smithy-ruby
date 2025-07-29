# frozen_string_literal: true

require 'nokogiri'

module Smithy
  module Xml
    class Parser
      # @api private
      class NokogiriEngine
        def initialize(stack)
          @stack = stack
        end

        def parse(xml)
          Nokogiri::XML::SAX::Parser.new(self).parse(xml)
        end

        def xmldecl(*_ignored); end
        def start_document; end
        def end_document; end
        def comment(*_ignored); end

        def start_element_namespace(name, attrs = [], *_ignored)
          @stack.start_element(name)
          attrs.each do |attr|
            localname = attr.localname
            localname = "#{attr.prefix}:#{localname}" if attr.prefix
            @stack.attr(localname, attr.value)
          end
        end

        def characters(chars)
          @stack.text(chars)
        end

        def end_element_namespace(*_ignored)
          @stack.end_element
        end

        def error(msg)
          @stack.error(msg)
        end
      end
    end
  end
end
